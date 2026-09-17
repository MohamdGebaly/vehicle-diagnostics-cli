import os
import psycopg2
from psycopg2.extras import RealDictCursor
from dotenv import load_dotenv
load_dotenv()
# Database connection configuration
DB_CONFIG = {
    "dbname": os.getenv("DB_NAME"),
    "user": os.getenv("DB_USER"),
    "password": os.getenv("DB_PASSWORD"),
    "host": os.getenv("DB_HOST"),
    "port": os.getenv("DB_PORT")
}

def get_connection():
    """Establishes and returns a connection to the PostgreSQL database."""
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        return conn
    except Exception as e:
        print(f"[Error] Failed to connect to database: {e}")
        return None

def log_sensor_reading(vehicle_id, sensor_name, sensor_value, unit):
    """Inserts a new sensor telemetry record into sensor_logs."""
    sql = """
        INSERT INTO sensor_logs (vehicle_id, sensor_name, sensor_value, unit)
        VALUES (%s, %s, %s, %s) RETURNING log_id;
    """
    conn = get_connection()
    if not conn:
        return None
    
    try:
        with conn.cursor() as cur:
            cur.execute(sql, (vehicle_id, sensor_name, sensor_value, unit))
            log_id = cur.fetchone()[0]
            conn.commit()
            return log_id
    except Exception as e:
        conn.rollback()
        print(f"[Error] Failed to log sensor data: {e}")
        return None
    finally:
        conn.close()

def log_fault_code(vehicle_id, dtc_code, severity, status, description):
    """Inserts a new diagnostic trouble code event into diagnostic_trouble_codes."""
    sql = """
        INSERT INTO diagnostic_trouble_codes 
        (vehicle_id, dtc_code, severity, status_of_vehicle, description_of_problem)
        VALUES (%s, %s, %s, %s, %s) RETURNING dtc_id;
    """
    conn = get_connection()
    if not conn:
        return None
    
    try:
        with conn.cursor() as cur:
            cur.execute(sql, (vehicle_id, dtc_code, severity, status, description))
            dtc_id = cur.fetchone()[0]
            conn.commit()
            return dtc_id
    except Exception as e:
        conn.rollback()
        print(f"[Error] Failed to log fault code: {e}")
        return None
    finally:
        conn.close()

def get_faults_last_24h(vehicle_id):
    """Queries active and historical DTCs for a vehicle within the last 24 hours."""
    sql = """
        SELECT 
            dtc_id,
            dtc_code,
            severity,
            status_of_vehicle,
            description_of_problem,
            time_stamp
        FROM diagnostic_trouble_codes
        WHERE vehicle_id = %s
          AND time_stamp >= NOW() - INTERVAL '24 hours'
        ORDER BY time_stamp DESC;
    """
    conn = get_connection()
    if not conn:
        return []
    
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(sql, (vehicle_id,))
            return cur.fetchall()
    except Exception as e:
        print(f"[Error] Failed to fetch fault logs: {e}")
        return []
    finally:
        conn.close()

def get_all_faults(vehicle_id):
    """Queries all historical diagnostic trouble codes for a specific vehicle."""
    sql = """
        SELECT 
            dtc_id,
            dtc_code,
            severity,
            status_of_vehicle,
            description_of_problem,
            time_stamp
        FROM diagnostic_trouble_codes
        WHERE vehicle_id = %s
        ORDER BY time_stamp DESC;
    """
    conn = get_connection()
    if not conn:
        return []
    
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(sql, (vehicle_id,))
            return cur.fetchall()
    except Exception as e:
        print(f"[Error] Failed to fetch all fault logs: {e}")
        return []
    finally:
        conn.close()

def get_vehicle_telemetry(vehicle_id, limit=10):
    """Fetches recent sensor logs for a specific vehicle."""
    sql = """
        SELECT log_id, sensor_name, sensor_value, unit, time_stamp
        FROM sensor_logs
        WHERE vehicle_id = %s
        ORDER BY time_stamp DESC
        LIMIT %s;
    """
    conn = get_connection()
    if not conn:
        return []
    
    try:
        with conn.cursor(cursor_factory=RealDictCursor) as cur:
            cur.execute(sql, (vehicle_id, limit))
            return cur.fetchall()
    except Exception as e:
        print(f"[Error] Failed to fetch telemetry: {e}")
        return []
    finally:
        conn.close()