---------------------------------------------------------------------
-- 1. Populate Vehicles
INSERT INTO vehicles (vehicle_id, model_name) VALUES
('VIN-FORD-F150-001', 'Ford F-150 Light-Duty'),
('VIN-TESLA-MY-002', 'Tesla Model Y Dual Motor'),
('VIN-BMW-330I-003', 'BMW 330i Sedan');

-- 2. Populate Sensor Telemetry (Normal Operation & Fault Conditions)
INSERT INTO sensor_logs (vehicle_id, time_stamp, sensor_name, sensor_value, unit) VALUES
-- Vehicle 1 Telemetry (Engine Misfire Scenario)
('VIN-FORD-F150-001', NOW() - INTERVAL '25 hours', 'engine_speed', 2100.00, 'RPM'),
('VIN-FORD-F150-001', NOW() - INTERVAL '25 hours', 'coolant_temp', 92.50, 'degC'),
('VIN-FORD-F150-001', NOW() - INTERVAL '2 hours', 'engine_speed', 3450.00, 'RPM'),
('VIN-FORD-F150-001', NOW() - INTERVAL '2 hours', 'coolant_temp', 108.30, 'degC'),
('VIN-FORD-F150-001', NOW() - INTERVAL '30 minutes', 'oil_pressure', 28.40, 'PSI'),

-- Vehicle 2 Telemetry (Low Voltage Scenario)
('VIN-TESLA-MY-002', NOW() - INTERVAL '5 hours', 'battery_voltage', 11.20, 'V'),
('VIN-TESLA-MY-002', NOW() - INTERVAL '1 hour', 'battery_voltage', 10.80, 'V'),
('VIN-TESLA-MY-002', NOW() - INTERVAL '15 minutes', 'vehicle_speed', 65.50, 'mph'),

-- Vehicle 3 Telemetry (Normal Driving)
('VIN-BMW-330I-003', NOW() - INTERVAL '4 hours', 'intake_air_temp', 32.00, 'degC'),
('VIN-BMW-330I-003', NOW() - INTERVAL '3 hours', 'maf_flow_rate', 14.80, 'g/s');

-- 3. Populate Real-World Diagnostic Trouble Codes (DTC Logs)
INSERT INTO diagnostic_trouble_codes (vehicle_id, time_stamp, dtc_code, severity, status_of_vehicle, description_of_problem) VALUES
-- Old fault (Older than 24h)
('VIN-FORD-F150-001', NOW() - INTERVAL '30 hours', 'P0171', 'MEDIUM', 'CLEARED', 'System Too Lean (Bank 1) - Fuel trim limit exceeded'),

-- Faults within the last 24 hours
('VIN-FORD-F150-001', NOW() - INTERVAL '2 hours', 'P0300', 'HIGH', 'ACTIVE', 'Random/Multiple Cylinder Misfire Detected'),
('VIN-FORD-F150-001', NOW() - INTERVAL '1 hour', 'P0217', 'CRITICAL', 'ACTIVE', 'Engine Coolant Over Temperature Condition'),

('VIN-TESLA-MY-002', NOW() - INTERVAL '5 hours', 'U0100', 'HIGH', 'ACTIVE', 'Lost Communication With ECM/PCM A'),
('VIN-TESLA-MY-002', NOW() - INTERVAL '1 hour', 'P0562', 'MEDIUM', 'PENDING', 'System Voltage Low - Battery rail dropped below threshold'),

('VIN-BMW-330I-003', NOW() - INTERVAL '12 hours', 'P0101', 'LOW', 'CLEARED', 'Mass or Volume Air Flow Sensor A Circuit Range/Performance');
--------------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Add More Vehicles
INSERT INTO vehicles (vehicle_id, model_name) VALUES
('VIN-CHEVY-SILV-004', 'Chevrolet Silverado 1500'),
('VIN-AUDI-A4-005', 'Audi A4 2.0 TFSI'),
('VIN-RIVIAN-R1T-006', 'Rivian R1T Quad-Motor');

-- 2. Add More Sensor Telemetry
INSERT INTO sensor_logs (vehicle_id, time_stamp, sensor_name, sensor_value, unit) VALUES
-- Chevy Silverado (Oil/Coolant Telemetry)
('VIN-CHEVY-SILV-004', NOW() - INTERVAL '18 hours', 'engine_speed', 1850.00, 'RPM'),
('VIN-CHEVY-SILV-004', NOW() - INTERVAL '18 hours', 'oil_pressure', 12.50, 'PSI'),
('VIN-CHEVY-SILV-004', NOW() - INTERVAL '6 hours', 'coolant_temp', 115.00, 'degC'),

-- Audi A4 (Boost & Air Flow Telemetry)
('VIN-AUDI-A4-005', NOW() - INTERVAL '10 hours', 'manifold_absolute_pressure', 85.20, 'kPa'),
('VIN-AUDI-A4-005', NOW() - INTERVAL '2 hours', 'intake_air_temp', 45.00, 'degC'),
('VIN-AUDI-A4-005', NOW() - INTERVAL '30 minutes', 'engine_speed', 4200.00, 'RPM'),

-- Rivian R1T (EV Inverter & Battery Telemetry)
('VIN-RIVIAN-R1T-006', NOW() - INTERVAL '14 hours', 'pack_temp', 38.50, 'degC'),
('VIN-RIVIAN-R1T-006', NOW() - INTERVAL '3 hours', 'inverter_temp', 88.20, 'degC'),
('VIN-RIVIAN-R1T-006', NOW() - INTERVAL '1 hour', 'battery_voltage', 380.40, 'V');

-- 3. Add More Diagnostic Trouble Codes (DTC Logs)
INSERT INTO diagnostic_trouble_codes (vehicle_id, time_stamp, dtc_code, severity, status_of_vehicle, description_of_problem) VALUES
-- Chevy Silverado Faults
('VIN-CHEVY-SILV-004', NOW() - INTERVAL '18 hours', 'P0522', 'HIGH', 'ACTIVE', 'Engine Oil Pressure Sensor/Switch Circuit Low Voltage'),
('VIN-CHEVY-SILV-004', NOW() - INTERVAL '6 hours', 'P0217', 'CRITICAL', 'ACTIVE', 'Engine Coolant Over Temperature Condition'),

-- Audi A4 Faults
('VIN-AUDI-A4-005', NOW() - INTERVAL '10 hours', 'P0299', 'MEDIUM', 'PENDING', 'Turbocharger/Supercharger A Underboost Condition'),
('VIN-AUDI-A4-005', NOW() - INTERVAL '2 hours', 'P0113', 'LOW', 'CLEARED', 'Intake Air Temperature Sensor 1 Circuit High Input'),

-- Rivian R1T Faults
('VIN-RIVIAN-R1T-006', NOW() - INTERVAL '3 hours', 'P0A3F', 'HIGH', 'ACTIVE', 'Drive Motor A Position Sensor Circuit Range/Performance');