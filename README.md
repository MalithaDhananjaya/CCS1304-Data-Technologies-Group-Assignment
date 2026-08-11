# 🏥 SmartCare Hospital Management System

A centralized **Relational Database Management System (RDBMS)** built with **MySQL** for SmartCare Hospital — a private healthcare institution in Sri Lanka. The system replaces manual, spreadsheet-based record-keeping with a normalized, constraint-driven database that automates appointments, room/bed allocation, treatments, lab tests, and billing.

> Group assignment for **CCS1304 – Data Technologies**

---

## 📌 Project Overview

SmartCare Hospital provides medical services across multiple departments (Cardiology, Pediatrics, Neurology, Orthopedics, Radiology). Manual record-keeping caused:

- Data duplication
- Appointment clashes
- Room allocation delays
- Billing errors

This project designs and implements a MySQL database that ensures **data integrity**, **reduces redundancy**, and enables **quick reporting** for hospital administration.

---

## 👥 Team Members

| Name | Student ID |
|---|---|
| M.G. Hirusha Praveen Sulakshana | CIT-25-02-0334 |
| Malitha Herath | CIT-25-02-0003 |
| Manula Gunawardhana | CIT-25-02-0393 |
| Tharusha Nuwanga | CIT-25-02-0288 |

---

## ⚙️ Tech Stack

- **Database:** MySQL 8.0
- **Tool:** MySQL Workbench / SQL client
- **Concepts applied:** ER Modeling, Normalization (1NF–3NF), DDL/DML, Views, Stored Procedures, User-Defined Functions, Triggers

---

## 🧩 Operational Requirements

- Efficient tracking of patient profiles, doctor availability, and department details
- Prevention of overlapping doctor appointment schedules
- Dynamic room availability tracking upon patient admission and discharge
- Accurate automated record management for treatments, lab tests, and billing

## 📐 System Assumptions

1. **Department & Doctor:** One department employs multiple doctors, but each doctor belongs to only one department.
2. **Appointments:** A doctor can consult multiple patients but cannot have two appointments at the exact same date/time.
3. **Medical Records:** Treatments and lab tests must be prescribed/requested by a registered doctor.
4. **Room Allocation:** A room holds one patient per bed; status toggles between `Available` and `Occupied`.

---

## 🗂️ Entity Relationship Summary

| Relationship | Description |
|---|---|
| `Department (1) : (N) Doctor` | One department employs many doctors |
| `Doctor (1) : (N) Appointment (N) : (1) Patient` | Doctors and patients connect via appointments |
| `Patient (1) : (N) Admission (N) : (1) Room` | Tracks patient stays and room allocation |
| `Room_Category (1) : (N) Room` | Categorizes rooms (ICU, Private, General) |
| `Doctor (1) : (N) Treatment / Lab_Test (N) : (1) Patient` | Prescriptions and lab test tracking |
| `Patient (1) : (N) Billing` | Captures financial records and payments |

**Core Entities:** `Department`, `Doctor`, `Patient`, `Appointment`, `Room_Category`, `Room`, `Admission`, `Treatment`, `Medicine`, `Prescription_Medicine`, `Lab_Test`, `Billing`

---

## 🧮 Normalization

- **1NF:** All attributes are atomic; repeating groups (e.g., appointments) moved into separate tables with unique primary keys.
- **2NF:** Eliminated partial dependencies — e.g., split Doctor and Department details into separate tables.
- **3NF:** Removed transitive dependencies — e.g., `daily_rate` moved from `Room` into `Room_Category`, referenced via `category_id`.

---

## 🏗️ Database Schema (Tables)

| # | Table | Purpose |
|---|---|---|
| 1 | `Department` | Hospital departments |
| 2 | `Doctor` | Doctor profiles, linked to a department |
| 3 | `Patient` | Patient demographic & contact info |
| 4 | `Appointment` | Doctor–patient consultations (unique per doctor/date/time) |
| 5 | `Room_Category` | Room types (ICU, Private, General Ward) with daily rate |
| 6 | `Room` | Individual rooms/beds, linked to a category |
| 7 | `Admission` | Patient admission & discharge tracking |
| 8 | `Treatment` | Diagnoses & prescriptions issued by doctors |
| 9 | `Medicine` | Medicine catalog |
| 10 | `Prescription_Medicine` | Medicines linked to a treatment |
| 11 | `Lab_Test` | Lab tests requested by doctors |
| 12 | `Billing` | Patient billing & payment records |

All tables use `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, and `CHECK` constraints (e.g., `consultation_fee > 0`, `total_amount >= 0`).

---

## 🚀 Getting Started

### Prerequisites
- MySQL Server 8.0+
- MySQL Workbench (or any SQL client)

### Setup
```bash
# 1. Clone the repository
git clone https://github.com/MalithaDhananjaya/CCS1304-Data-Technologies-Group-Assignment.git
cd CCS1304-Data-Technologies-Group-Assignment

# 2. Create the database, tables & sample data
mysql -u root -p < database_schema.sql

# 3. Run views, stored procedures, functions & triggers
mysql -u root -p < Script/views.sql
mysql -u root -p < Script/sp_AdmitPatient.sql
mysql -u root -p < Script/sp_GetDoctorAppointments.sql
mysql -u root -p < Script/sp_ScheduleAppointment_DischargePatient.sql
mysql -u root -p < Script/fn_CalculateAge.sql
mysql -u root -p < Script/fn_GetTotalPaidByPatient.sql
mysql -u root -p < Script/triggers.sql

# 4. Run any sample query
mysql -u root -p SmartCareDB < Script/Queries_1.sql
```

`database_schema.sql` will:
1. Drop and recreate the `SmartCareDB` database
2. Create all 12 tables with constraints
3. Insert sample data (10 patients, 5 doctors, 5 departments, 15 appointments, 10 bills)

---

## 🔍 Sample Queries (`Script/Queries_1.sql` – `Queries_10.sql`)

| # | Query |
|---|---|
| 1 | Display all patient details |
| 2 | List doctors grouped by department |
| 3 | Appointments scheduled for a specific doctor |
| 4 | Patients admitted to ICU rooms |
| 5 | Display unpaid bills |
| 6 | Calculate total revenue generated |
| 7 | Find the most frequently visited doctor |
| 8 | Patients with multiple appointments |
| 9 | Lab tests completed within a date range |
| 10 | Display current room availability |

---

## 👁️ Views (`Script/views.sql`)

| View | Description |
|---|---|
| `vw_Patient_Medical_Summary` | Combines patient details, diagnoses, and prescriptions for quick clinical lookup |
| `vw_Active_Admissions` | Real-time list of occupied rooms and currently admitted patients |

## ⚡ Stored Procedures

| Procedure | File | Description |
|---|---|---|
| `sp_ScheduleAppointment` | `sp_ScheduleAppointment_DischargePatient.sql` | Schedules a new appointment |
| `sp_DischargePatient` | `sp_ScheduleAppointment_DischargePatient.sql` | Discharges a patient and frees up the room |
| `sp_GetDoctorAppointments` | `sp_GetDoctorAppointments.sql` | Fetches all upcoming scheduled consultations for a doctor |
| `sp_AdmitPatient` | `sp_AdmitPatient.sql` | Admits a patient and marks the room as `Occupied` |

## 🧠 User-Defined Functions

| Function | File | Description |
|---|---|---|
| `fn_CalculateAge` | `fn_CalculateAge.sql` | Returns a patient's current age calculated from their date of birth |
| `fn_GetTotalPaidByPatient` | `fn_GetTotalPaidByPatient.sql` | Returns the total paid bill amount for a given patient |

## 🔔 Triggers (`Script/triggers.sql`)

| Trigger | Event | Action |
|---|---|---|
| `trg_AfterAdmissionInsert` | `AFTER INSERT` on `Admission` | Sets room status to `Occupied` |
| `trg_After_Discharge_Update` | `AFTER UPDATE` on `Admission` | Sets room status back to `Available` |
| `trg_BeforeAppointmentInsert` | `BEFORE INSERT` on `Appointment` | Blocks scheduling appointments in the past |

---

## 📁 Repository Structure

```
CCS1304-Data-Technologies-Group-Assignment/
├── README.md
├── database_schema.sql                              # Tables, constraints, sample data
└── Script/
    ├── Queries_1.sql ... Queries_10.sql              # Task 06 – SQL queries
    ├── views.sql                                     # Task 07 – Views
    ├── sp_AdmitPatient.sql                           # Task 08 – Stored procedure
    ├── sp_GetDoctorAppointments.sql                  # Task 08 – Stored procedure
    ├── sp_ScheduleAppointment_DischargePatient.sql   # Task 08 – Stored procedures
    ├── fn_CalculateAge.sql                           # Task 09 – Function
    ├── fn_GetTotalPaidByPatient.sql                  # Task 09 – Function
    └── triggers.sql                                  # Task 10 – Triggers
```

---

## ✅ Conclusion

The SmartCare Hospital Management System addresses the limitations of manual record-keeping. Normalizing the schema to 3NF eliminated redundancy, while SQL constraints ensured relational data integrity. Triggers and stored procedures automate room management and admission tracking, providing a scalable and accurate foundation for hospital operations.

---

## 📚 References

- [W3Schools MySQL](https://www.w3schools.com/MYSQL/default.asp)
- [GeeksforGeeks – Enhanced ER Model](https://www.geeksforgeeks.org/dbms/enhanced-er-model/)
- [GeeksforGeeks – Relational Algebra](https://www.geeksforgeeks.org/dbms/introduction-of-relational-algebra-in-dbms/)
- [MySQL 8.0 Reference Manual](https://dev.mysql.com/doc/refman/8.0/en/)
- *Database System Concepts* — Silberschatz, Korth, Sudarshan
- *Fundamentals of Database Systems* — Elmasri, Navathe
- *Murach's MySQL* — Joel Murach

---

## 📄 License

This project was created for academic purposes as part of the CCS1304 Data Technologies module.
