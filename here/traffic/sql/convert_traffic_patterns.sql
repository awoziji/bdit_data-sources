/*Converting trip patterns from wide format to narrow */

/*traffic_pattern_spd_60*/

SELECT pattern_id, trange, pattern_speed
INTO here.traffic_pattern_spd_60_narrow
FROM here.traffic_pattern_spd_60,
LATERAL json_to_recordset(json_build_array(
json_build_object('trange', timerange('00:00'::TIME, ('00:00' + interval '1 hour')::TIME), 'pattern_speed', h00_00),
json_build_object('trange', timerange('01:00'::TIME, ('01:00' + interval '1 hour')::TIME), 'pattern_speed', h01_00),
json_build_object('trange', timerange('02:00'::TIME, ('02:00' + interval '1 hour')::TIME), 'pattern_speed', h02_00),
json_build_object('trange', timerange('03:00'::TIME, ('03:00' + interval '1 hour')::TIME), 'pattern_speed', h03_00),
json_build_object('trange', timerange('04:00'::TIME, ('04:00' + interval '1 hour')::TIME), 'pattern_speed', h04_00),
json_build_object('trange', timerange('05:00'::TIME, ('05:00' + interval '1 hour')::TIME), 'pattern_speed', h05_00),
json_build_object('trange', timerange('06:00'::TIME, ('06:00' + interval '1 hour')::TIME), 'pattern_speed', h06_00),
json_build_object('trange', timerange('07:00'::TIME, ('07:00' + interval '1 hour')::TIME), 'pattern_speed', h07_00),
json_build_object('trange', timerange('08:00'::TIME, ('08:00' + interval '1 hour')::TIME), 'pattern_speed', h08_00),
json_build_object('trange', timerange('09:00'::TIME, ('09:00' + interval '1 hour')::TIME), 'pattern_speed', h09_00),
json_build_object('trange', timerange('10:00'::TIME, ('10:00' + interval '1 hour')::TIME), 'pattern_speed', h10_00),
json_build_object('trange', timerange('11:00'::TIME, ('11:00' + interval '1 hour')::TIME), 'pattern_speed', h11_00),
json_build_object('trange', timerange('12:00'::TIME, ('12:00' + interval '1 hour')::TIME), 'pattern_speed', h12_00),
json_build_object('trange', timerange('13:00'::TIME, ('13:00' + interval '1 hour')::TIME), 'pattern_speed', h13_00),
json_build_object('trange', timerange('14:00'::TIME, ('14:00' + interval '1 hour')::TIME), 'pattern_speed', h14_00),
json_build_object('trange', timerange('15:00'::TIME, ('15:00' + interval '1 hour')::TIME), 'pattern_speed', h15_00),
json_build_object('trange', timerange('16:00'::TIME, ('16:00' + interval '1 hour')::TIME), 'pattern_speed', h16_00),
json_build_object('trange', timerange('17:00'::TIME, ('17:00' + interval '1 hour')::TIME), 'pattern_speed', h17_00),
json_build_object('trange', timerange('18:00'::TIME, ('18:00' + interval '1 hour')::TIME), 'pattern_speed', h18_00),
json_build_object('trange', timerange('19:00'::TIME, ('19:00' + interval '1 hour')::TIME), 'pattern_speed', h19_00),
json_build_object('trange', timerange('20:00'::TIME, ('20:00' + interval '1 hour')::TIME), 'pattern_speed', h20_00),
json_build_object('trange', timerange('21:00'::TIME, ('21:00' + interval '1 hour')::TIME), 'pattern_speed', h21_00),
json_build_object('trange', timerange('22:00'::TIME, ('22:00' + interval '1 hour')::TIME), 'pattern_speed', h22_00),
json_build_object('trange', timerange('23:00'::TIME, ('23:00' + interval '59 minutes')::TIME), 'pattern_speed', h23_00))) 
AS smth(trange timerange, pattern_speed int);

CREATE INDEX ON here.traffic_pattern_spd_60_narrow(pattern_id);
CREATE INDEX ON here.traffic_pattern_spd_60_narrow USING GIST(trange);


SELECT pattern_id, trange as trange, pattern_speed
INTO here.traffic_pattern_18_spd_15_narrow
FROM here.traffic_pattern_18_spd_15,
LATERAL json_to_recordset(json_build_array(
    json_build_object('trange', timerange('00:00'::TIME, ('00:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h00_00),
    json_build_object('trange', timerange('00:15'::TIME, ('00:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h00_15),
    json_build_object('trange', timerange('00:30'::TIME, ('00:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h00_30),
    json_build_object('trange', timerange('00:45'::TIME, ('00:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h00_45),
    json_build_object('trange', timerange('01:00'::TIME, ('01:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h01_00),
    json_build_object('trange', timerange('01:15'::TIME, ('01:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h01_15),
    json_build_object('trange', timerange('01:30'::TIME, ('01:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h01_30),
    json_build_object('trange', timerange('01:45'::TIME, ('01:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h01_45),
    json_build_object('trange', timerange('02:00'::TIME, ('02:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h02_00),
    json_build_object('trange', timerange('02:15'::TIME, ('02:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h02_15),
    json_build_object('trange', timerange('02:30'::TIME, ('02:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h02_30),
    json_build_object('trange', timerange('02:45'::TIME, ('02:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h02_45),
    json_build_object('trange', timerange('03:00'::TIME, ('03:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h03_00),
    json_build_object('trange', timerange('03:15'::TIME, ('03:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h03_15),
    json_build_object('trange', timerange('03:30'::TIME, ('03:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h03_30),
    json_build_object('trange', timerange('03:45'::TIME, ('03:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h03_45),
    json_build_object('trange', timerange('04:00'::TIME, ('04:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h04_00),
    json_build_object('trange', timerange('04:15'::TIME, ('04:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h04_15),
    json_build_object('trange', timerange('04:30'::TIME, ('04:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h04_30),
    json_build_object('trange', timerange('04:45'::TIME, ('04:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h04_45),
    json_build_object('trange', timerange('05:00'::TIME, ('05:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h05_00),
    json_build_object('trange', timerange('05:15'::TIME, ('05:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h05_15),
    json_build_object('trange', timerange('05:30'::TIME, ('05:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h05_30),
    json_build_object('trange', timerange('05:45'::TIME, ('05:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h05_45),
    json_build_object('trange', timerange('06:00'::TIME, ('06:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h06_00),
    json_build_object('trange', timerange('06:15'::TIME, ('06:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h06_15),
    json_build_object('trange', timerange('06:30'::TIME, ('06:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h06_30),
    json_build_object('trange', timerange('06:45'::TIME, ('06:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h06_45),
    json_build_object('trange', timerange('07:00'::TIME, ('07:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h07_00),
    json_build_object('trange', timerange('07:15'::TIME, ('07:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h07_15),
    json_build_object('trange', timerange('07:30'::TIME, ('07:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h07_30),
    json_build_object('trange', timerange('07:45'::TIME, ('07:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h07_45),
    json_build_object('trange', timerange('08:00'::TIME, ('08:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h08_00),
    json_build_object('trange', timerange('08:15'::TIME, ('08:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h08_15),
    json_build_object('trange', timerange('08:30'::TIME, ('08:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h08_30),
    json_build_object('trange', timerange('08:45'::TIME, ('08:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h08_45),
    json_build_object('trange', timerange('09:00'::TIME, ('09:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h09_00),
    json_build_object('trange', timerange('09:15'::TIME, ('09:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h09_15),
    json_build_object('trange', timerange('09:30'::TIME, ('09:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h09_30),
    json_build_object('trange', timerange('09:45'::TIME, ('09:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h09_45),
    json_build_object('trange', timerange('10:00'::TIME, ('10:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h10_00),
    json_build_object('trange', timerange('10:15'::TIME, ('10:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h10_15),
    json_build_object('trange', timerange('10:30'::TIME, ('10:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h10_30),
    json_build_object('trange', timerange('10:45'::TIME, ('10:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h10_45),
    json_build_object('trange', timerange('11:00'::TIME, ('11:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h11_00),
    json_build_object('trange', timerange('11:15'::TIME, ('11:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h11_15),
    json_build_object('trange', timerange('11:30'::TIME, ('11:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h11_30),
    json_build_object('trange', timerange('11:45'::TIME, ('11:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h11_45),
    json_build_object('trange', timerange('12:00'::TIME, ('12:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h12_00),
    json_build_object('trange', timerange('12:15'::TIME, ('12:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h12_15),
    json_build_object('trange', timerange('12:30'::TIME, ('12:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h12_30),
    json_build_object('trange', timerange('12:45'::TIME, ('12:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h12_45),
    json_build_object('trange', timerange('13:00'::TIME, ('13:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h13_00),
    json_build_object('trange', timerange('13:15'::TIME, ('13:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h13_15),
    json_build_object('trange', timerange('13:30'::TIME, ('13:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h13_30),
    json_build_object('trange', timerange('13:45'::TIME, ('13:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h13_45),
    json_build_object('trange', timerange('14:00'::TIME, ('14:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h14_00),
    json_build_object('trange', timerange('14:15'::TIME, ('14:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h14_15),
    json_build_object('trange', timerange('14:30'::TIME, ('14:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h14_30),
    json_build_object('trange', timerange('14:45'::TIME, ('14:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h14_45),
    json_build_object('trange', timerange('15:00'::TIME, ('15:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h15_00),
    json_build_object('trange', timerange('15:15'::TIME, ('15:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h15_15),
    json_build_object('trange', timerange('15:30'::TIME, ('15:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h15_30),
    json_build_object('trange', timerange('15:45'::TIME, ('15:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h15_45),
    json_build_object('trange', timerange('16:00'::TIME, ('16:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h16_00),
    json_build_object('trange', timerange('16:15'::TIME, ('16:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h16_15),
    json_build_object('trange', timerange('16:30'::TIME, ('16:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h16_30),
    json_build_object('trange', timerange('16:45'::TIME, ('16:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h16_45),
    json_build_object('trange', timerange('17:00'::TIME, ('17:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h17_00),
    json_build_object('trange', timerange('17:15'::TIME, ('17:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h17_15),
    json_build_object('trange', timerange('17:30'::TIME, ('17:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h17_30),
    json_build_object('trange', timerange('17:45'::TIME, ('17:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h17_45),
    json_build_object('trange', timerange('18:00'::TIME, ('18:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h18_00),
    json_build_object('trange', timerange('18:15'::TIME, ('18:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h18_15),
    json_build_object('trange', timerange('18:30'::TIME, ('18:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h18_30),
    json_build_object('trange', timerange('18:45'::TIME, ('18:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h18_45),
    json_build_object('trange', timerange('19:00'::TIME, ('19:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h19_00),
    json_build_object('trange', timerange('19:15'::TIME, ('19:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h19_15),
    json_build_object('trange', timerange('19:30'::TIME, ('19:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h19_30),
    json_build_object('trange', timerange('19:45'::TIME, ('19:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h19_45),
    json_build_object('trange', timerange('20:00'::TIME, ('20:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h20_00),
    json_build_object('trange', timerange('20:15'::TIME, ('20:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h20_15),
    json_build_object('trange', timerange('20:30'::TIME, ('20:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h20_30),
    json_build_object('trange', timerange('20:45'::TIME, ('20:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h20_45),
    json_build_object('trange', timerange('21:00'::TIME, ('21:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h21_00),
    json_build_object('trange', timerange('21:15'::TIME, ('21:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h21_15),
    json_build_object('trange', timerange('21:30'::TIME, ('21:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h21_30),
    json_build_object('trange', timerange('21:45'::TIME, ('21:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h21_45),
    json_build_object('trange', timerange('22:00'::TIME, ('22:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h22_00),
    json_build_object('trange', timerange('22:15'::TIME, ('22:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h22_15),
    json_build_object('trange', timerange('22:30'::TIME, ('22:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h22_30),
    json_build_object('trange', timerange('22:45'::TIME, ('22:45'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h22_45),
    json_build_object('trange', timerange('23:00'::TIME, ('23:00'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h23_00),
    json_build_object('trange', timerange('23:15'::TIME, ('23:15'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h23_15),
    json_build_object('trange', timerange('23:30'::TIME, ('23:30'+INTERVAL '15 minutes')::TIME), 'pattern_speed', h23_30),
    json_build_object('trange', timerange('23:45'::TIME, ('23:45'+INTERVAL '14 minutes')::TIME), 'pattern_speed', h23_45)))
    AS smth(trange timerange, pattern_speed int);

CREATE INDEX ON here.traffic_pattern_18_spd_15_narrow(pattern_id);
CREATE INDEX ON here.traffic_pattern_18_spd_15_narrow USING GIST(trange);


/*Traffic pattern reference*/

SELECT link_pvid || travel_direction AS link_dir,isodow, pattern_id
INTO here.traffic_pattern_18_ref_narrow
	FROM here.traffic_pattern_18_ref, 
    LATERAL json_to_recordset(json_build_array(
        json_build_object('isodow',0,'pattern_id', u),
        json_build_object('isodow',1,'pattern_id', m),
        json_build_object('isodow',2,'pattern_id', t),
        json_build_object('isodow',3,'pattern_id', w),
        json_build_object('isodow',4,'pattern_id', r),
        json_build_object('isodow',5,'pattern_id', f),
        json_build_object('isodow',6,'pattern_id', s)))
    AS smth(isodow int, pattern_id int);

CREATE INDEX ON here.traffic_pattern_18_ref_narrow (link_dir);
CREATE INDEX ON here.traffic_pattern_18_ref_narrow (isodow);
ANALYZE here.traffic_pattern_18_ref_narrow;


CREATE VIEW here.traffic_pattern_18_spd_15min AS

SELECT link_dir, isodow, trange, pattern_speed  
	FROM here.traffic_pattern_18_ref_narrow
INNER JOIN here.traffic_pattern_18_spd_15_narrow USING (pattern_id);


CREATE VIEW here.traffic_pattern_18_spd_60min AS

SELECT link_dir, isodow, trange, pattern_speed  
	FROM here.traffic_pattern_18_ref_narrow
INNER JOIN here.traffic_pattern_18_spd_60_narrow USING (pattern_id);

/* VIEW to fill in traffic analytics values*/
CREATE OR REPLACE VIEW here.ta_filled AS

SELECT master_lookup.link_dir, tx, COALESCE(pct_50, pattern_speed) as speed

FROM (SELECT link_dir, 
	  		 isodow, (dt + INTERVAL '1 day' * (isodow -1) + ref_time::TIME)::TIMESTAMP as tx, ref_time::TIME
	  FROM generate_series('2012-01-01 00:00'::timestamp, '2012-01-01 23:55'::timestamp, INTERVAL '5 minutes') as ref_time
	  CROSS JOIN generate_series(1,7) as isodow
	  CROSS JOIN generate_series('2011-12-26'::DATE, '2019-12-31'::DATE, INTERVAL '1 week') as dt
 	  CROSS JOIN here.routing_streets_18_3
	  ) as master_lookup
LEFT OUTER JOIN here.ta USING (link_dir, tx)
LEFT OUTER JOIN here.traffic_pattern_18_spd_15min ref_spds ON ref_spds.link_dir = master_lookup.link_dir
													 AND  ref_time <@ trange
													 AND ref_spds.isodow = master_lookup.isodow
