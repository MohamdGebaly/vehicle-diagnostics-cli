CREATE DATABASE diagnostic_cli;
CREATE  TABLE vehicles(
                    vehicle_id VARCHAR(50) PRIMARY KEY
                    ,model_name VARCHAR(100) NOT NULL,
                    created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP);


CREATE  TABLE sensor_logs(
                            log_id BIGSERIAL PRIMARY KEY,
                            vehicle_id VARCHAR(50),CONSTRAINT fk_sensor_logs_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
                            time_stamp TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
                            sensor_name VARCHAR(50) NOT NULL,
                            sensor_value NUMERIC(10, 2) NOT NULL,
                            unit VARCHAR(20) NOT NULL);
CREATE TABLE diagnostic_trouble_codes(
                                        dtc_id BIGSERIAL PRIMARY KEY,
                                        vehicle_id VARCHAR(50),CONSTRAINT fk_dtc_vehicle FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
                                        time_stamp TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                        dtc_code VARCHAR(10) NOT NULL ,
                                        severity VARCHAR(20) CHECK (severity IN ('LOW', 'MEDIUM', 'HIGH', 'CRITICAL')),
                                        status_of_vehicle VARCHAR(20) CHECK (status_of_vehicle IN ('ACTIVE', 'PENDING', 'CLEARED')),
                                        description_of_problem TEXT  );


