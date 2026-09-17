SELECT dtc_id,
       vehicle_id,
       time_stamp,
       dtc_code,
       severity,
       status_of_vehicle,
       description_of_problem
FROM public.diagnostic_trouble_codes
LIMIT 1000;