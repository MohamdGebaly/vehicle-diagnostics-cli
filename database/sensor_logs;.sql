SELECT log_id,
       vehicle_id,
       time_stamp,
       sensor_name,
       sensor_value,
       unit
FROM public.sensor_logs
LIMIT 1000;