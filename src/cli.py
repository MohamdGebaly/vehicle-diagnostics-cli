from src.db import (
    log_sensor_reading,
    log_fault_code,
    get_faults_last_24h,
    get_all_faults,
    get_vehicle_telemetry
)

def display_menu():
    print("\n==========================================")
    print("   VEHICLE DIAGNOSTICS & TELEMETRY CLI   ")
    print("==========================================")
    print("1. Log New Sensor Reading")
    print("2. Log New Diagnostic Trouble Code (DTC)")
    print("3. Query Faults in Last 24 Hours")
    print("4. Query All Faults (All Time)")
    print("5. View Recent Vehicle Telemetry")
    print("6. Exit")
    print("==========================================")

def handle_log_sensor():
    print("\n--- Log Sensor Reading ---")
    vehicle_id = input("Enter Vehicle ID (e.g., VIN-FORD-F150-001): ").strip()
    sensor_name = input("Enter Sensor Name (e.g., coolant_temp, engine_speed): ").strip()
    try:
        sensor_value = float(input("Enter Sensor Value: ").strip())
    except ValueError:
        print("[Error] Invalid numerical value.")
        return
    unit = input("Enter Unit (e.g., degC, RPM, PSI): ").strip()

    log_id = log_sensor_reading(vehicle_id, sensor_name, sensor_value, unit)
    if log_id:
        print(f" Success! Telemetry recorded with Log ID: {log_id}")

def handle_log_fault():
    print("\n--- Log Diagnostic Trouble Code ---")
    vehicle_id = input("Enter Vehicle ID: ").strip()
    dtc_code = input("Enter DTC Code (e.g., P0300): ").strip()
    severity = input("Enter Severity (LOW, MEDIUM, HIGH, CRITICAL): ").strip().upper()
    status = input("Enter Status (ACTIVE, PENDING, CLEARED): ").strip().upper()
    description = input("Enter Description: ").strip()

    dtc_id = log_fault_code(vehicle_id, dtc_code, severity, status, description)
    if dtc_id:
        print(f" Success! Fault recorded with DTC ID: {dtc_id}")

def handle_query_faults():
    print("\n--- Query Last 24 Hours Faults ---")
    vehicle_id = input("Enter Vehicle ID: ").strip()
    faults = get_faults_last_24h(vehicle_id)

    if not faults:
        print(f"No fault records found for {vehicle_id} in the last 24 hours.")
        return

    print(f"\nFound {len(faults)} fault(s) for {vehicle_id}:")
    print("-" * 75)
    for f in faults:
        print(f"[{f['time_stamp']}] Code: {f['dtc_code']} | Severity: {f['severity']} | Status: {f['status_of_vehicle']}")
        print(f" Description: {f['description_of_problem']}")
        print("-" * 75)

def handle_query_all_faults():
    print("\n--- Query All Vehicle Faults (All Time) ---")
    vehicle_id = input("Enter Vehicle ID: ").strip()
    faults = get_all_faults(vehicle_id)

    if not faults:
        print(f"No fault records found for {vehicle_id}.")
        return

    print(f"\nFound {len(faults)} total fault(s) for {vehicle_id}:")
    print("-" * 75)
    for f in faults:
        print(f"[{f['time_stamp']}] Code: {f['dtc_code']} | Severity: {f['severity']} | Status: {f['status_of_vehicle']}")
        print(f" Description: {f['description_of_problem']}")
        print("-" * 75)

def handle_query_telemetry():
    print("\n--- View Recent Vehicle Telemetry ---")
    vehicle_id = input("Enter Vehicle ID: ").strip()
    telemetry = get_vehicle_telemetry(vehicle_id)

    if not telemetry:
        print(f"No telemetry logs found for {vehicle_id}.")
        return

    print(f"\nRecent Telemetry for {vehicle_id}:")
    print("-" * 60)
    for t in telemetry:
        print(f"[{t['time_stamp']}] {t['sensor_name']}: {t['sensor_value']} {t['unit']}")
    print("-" * 60)

def run_cli():
    while True:
        display_menu()
        choice = input("Select an option (1-6): ").strip()

        if choice == '1':
            handle_log_sensor()
        elif choice == '2':
            handle_log_fault()
        elif choice == '3':
            handle_query_faults()
        elif choice == '4':
            handle_query_all_faults()  # <-- Added route
        elif choice == '5':
            handle_query_telemetry()
        elif choice == '6':
            print("\nExiting Vehicle Diagnostics CLI. Goodbye!")
            break
        else:
            print("[Error] Invalid selection. Please choose an option from 1 to 6.")