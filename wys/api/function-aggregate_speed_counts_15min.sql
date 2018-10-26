﻿CREATE OR REPLACE FUNCTION wys.aggregate_speed_counts_15min()
  RETURNS integer AS
$BODY$

BEGIN
	DROP TABLE IF EXISTS bins;

	CREATE TEMPORARY TABLE bins (
			api_id integer,
			datetime_bin timestamp without time zone,
			start_time timestamp without time zone,
			end_time timestamp without time zone
			);
			
	WITH bin_grouping AS (

		SELECT 	api_id, 
			min(datetime_bin) AS start_time,
			max(datetime_bin) AS end_time,
			TIMESTAMP WITHOUT TIME ZONE 'epoch' + INTERVAL '1 second' * (floor((extract('epoch' from A.datetime_bin)) / 900) * 900) AS datetime_bin
		FROM 	wys.raw_data A
		GROUP BY api_id, datetime_bin
	)
	
	INSERT INTO 	bins
	SELECT 		api_id,
			datetime_bin,
			start_time,
			end_time
	FROM 		bin_grouping
	ORDER BY api_id, datetime_bin;



	WITH speed_bins AS (
		SELECT api_id, datetime_bin, floor(speed/5)*5 AS speed, sum(count) AS count
		FROM wys.raw_data
		GROUP BY api_id, datetime_bin, floor(speed/5)*5
	), insert_data AS ( 

	INSERT INTO wys.counts_15min (api_id, datetime_bin, speed, count)
	SELECT 	B.api_id,
		B.datetime_bin,
		A.speed,
		sum(A.count) AS count
	FROM bins B
	INNER JOIN speed_bins A 
								ON A.api_id=B.api_id
								AND A.datetime_bin BETWEEN B.start_time AND B.end_time

	GROUP BY B.api_id, B.datetime_bin, A.speed
	ORDER BY B.api_id, B.datetime_bin, A.speed
	RETURNING counts_15min, api_id, datetime_bin)

	UPDATE wys.raw_data A
	SET counts_15min=B.counts_15min
	FROM insert_data B
	WHERE A.counts_15min IS NULL
	AND A.api_id=B.api_id
	AND A.datetime_bin >= B.datetime_bin AND A.datetime_bin < B.datetime_bin + INTERVAL '15 minutes' ;
	RETURN 1;
END;

$BODY$
  LANGUAGE plpgsql VOLATILE SECURITY DEFINER
  COST 100;