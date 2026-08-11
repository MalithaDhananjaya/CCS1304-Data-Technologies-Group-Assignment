# 🏥 SmartCare Hospital Management System

![Institution](https://img.shields.io/badge/Institution-Sri_Lanka_Technology_Campus_(SLTC)-blue)
![Course](https://img.shields.io/badge/Course-CCS1304__Data__Technologies-orange)
![Database](https://img.shields.io/badge/Database-MySQL_8.0-blue?logo=mysql)

A centralized Relational Database Management System (RDBMS) developed for **SmartCare Hospital** to replace manual record-keeping, streamline patient admission workflows, prevent appointment overlapping, and manage billing accurately.

---

## 👥 Group Members

| Name | Student ID |
| :--- | :--- |
| **M.G. Hirusha Praveen Sulakshana** | CIT-25-02-0334 |
| **Malitha Herath** | CIT-25-02-0003 |
| **Manula Gunawardhana** | CIT-25-02-0393 |
| **Tharusha Nuwanga** | CIT-25-02-0288 |

---

## 📌 Project Overview

SmartCare Hospital provides services across multiple departments (Cardiology, Pediatrics, Neurology, Orthopedics, and Radiology). This system is designed to solve core operational issues such as data duplication, appointment clashes, room allocation delays, and manual billing errors.

### Key Highlights:
* **System Normalization:** Designed up to Third Normal Form (3NF) to eliminate data redundancy.
* **Automated Room Allocation:** Dynamic room status changes between `Available` and `Occupied` via triggers/procedures.
* **Schedule Integrity:** Constraints to prevent overlapping appointment slots for doctors.
* **Advanced RDBMS Logic:** Utilizes Views, Stored Procedures, Functions, and Triggers for business operations.

---

## 🗄️ Database Architecture & Normalization

### Relational Schema Summary
1. **Department (1 : N) Doctor:** A department employs multiple doctors.
2. **Doctor (1 : N) Appointment (N : 1) Patient:** Connects medical staff with patients.
3. **Patient (1 : N) Admission (N : 1) Room:** Tracks inpatient stays and hospital bed availability.
4. **Room_Category (1 : N) Room:** Categorizes room types (ICU, Private Room, General Ward) and daily rates.
5. **Doctor (1 : N) Treatment / Lab_Test (N : 1) Patient:** Tracks medical diagnoses, prescriptions, and lab reports.
6. **Patient (1 : N) Billing:** Financial records and payment tracking.

---

## 💻 Database Objects & Features

### 1. Database Schema & Tables
Includes tables with `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, and `CHECK` constraints:
* `Department`, `Doctor`, `Patient`, `Appointment`
* `Room_Category`, `Room`, `Admission`
* `Treatment`, `Medicine`, `Prescription_Medicine`, `Lab_Test`, `Billing`

### 2. Views (`Task 07`)
* `vw_Patient_Medical_Summary`: Consolidates patient diagnosis and prescriptions for quick clinical lookup.
* `vw_Active_Admissions`: Displays currently occupied rooms and inpatient summaries in real-time.

### 3. Stored Procedures (`Task 08`)
* `sp_ScheduleAppointment`: Automates scheduling appointments with validations.
* `sp_DischargePatient`: Updates admission status and sets room status back to `Available`.

### 4. User-Defined Functions (`Task 09`)
* `fn_CalculateAdmissionCharge`: Calculates total room stay charges based on admission/discharge duration.
* `fn_GetPatientAge`: Computes patient age dynamically from date of birth.

### 5. Triggers (`Task 10`)
* `trg_AfterAdmissionInsert`: Marks room as `Occupied` automatically when a patient is admitted.
* `trg_BeforeAppointmentInsert`: Restricts scheduling appointments on past dates.

---

## 🛠️ How to Run / Setup

1. **Clone the Repository:**
   ```bash
   git clone [https://github.com/MalithaDhananjaya/CCS1304-Data-Technologies-Group-Assignment.git](https://github.com/MalithaDhananjaya/CCS1304-Data-Technologies-Group-Assignment.git)

   Import the Database:

Open MySQL Workbench or your preferred SQL client.

Open and execute the provided .sql file (Database_Creation_&_Data_Insertion.sql).

Verify:

SQL
USE SmartCareDB;
SELECT * FROM Patient;
📚 References
Silberschatz, A., Korth, H. F., & Sudarshan, S. — Database System Concepts

Elmasri, R., & Navathe, S. B. — Fundamentals of Database Systems

MySQL Documentation

GeeksforGeeks DBMS Reference
