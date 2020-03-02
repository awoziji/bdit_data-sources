-- View: open_data.wys_stationary_detailed

-- DROP VIEW open_data.wys_stationary_detailed;

CREATE OR REPLACE VIEW open_data.wys_stationary_detailed
 AS
 SELECT od.sign_id,
    loc.address,
    loc.dir,
    agg.datetime_bin,
    speed_bins.speed_bin::text AS speed_bin,
    agg.volume
   FROM open_data.wys_stationary_locations od
     JOIN wys.stationary_signs loc USING (sign_id)
     JOIN wys.speed_counts_agg agg ON loc.api_id = agg.api_id AND agg.datetime_bin >= od.start_date AND agg.datetime_bin < od.end_date
     JOIN wys.speed_bins USING (speed_id)
  WHERE agg.datetime_bin >= '2019-01-01'::date AND agg.datetime_bin < date_trunc('month'::text, now());

ALTER TABLE open_data.wys_stationary_detailed
    OWNER TO rdumas;

GRANT SELECT ON TABLE open_data.wys_stationary_detailed TO od_extract_svc;
GRANT ALL ON TABLE open_data.wys_stationary_detailed TO rdumas;
GRANT SELECT ON TABLE open_data.wys_stationary_detailed TO bdit_humans;
