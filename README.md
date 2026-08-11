<div align="center">

# 🏥 SmartCare Hospital Management System
**CCS1304 — Data Technologies Group Assignment**

[![Institution](https://img.shields.io/badge/Institution-Sri_Lanka_Technology_Campus_(SLTC)-0056b3?style=for-the-badge&logo=academic-pages)](https://sltc.ac.lk/)
[![Course](https://img.shields.io/badge/Course-CCS1304__Data__Technologies-e65100?style=for-the-badge)](https://sltc.ac.lk/)
[![Database](https://img.shields.io/badge/Database-MySQL_8.0-00758f?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)

<p align="center">
  A centralized Relational Database Management System (RDBMS) developed to automate hospital workflows, streamline patient admissions, prevent appointment overlaps, and eliminate data redundancy.
</p>

---

</div>

## 👥 Group Members

| Name | Student ID | Role |
| :--- | :---: | :---: |
| **M.G. Hirusha Praveen Sulakshana** | `CIT-25-02-0334` | Member |
| **Malitha Herath** | `CIT-25-02-0003` | Member |
| **Manula Gunawardhana** | `CIT-25-02-0393` | Member |
| **Tharusha Nuwanga** | `CIT-25-02-0288` | Member |

---

## 📌 Project Overview

SmartCare Hospital operates across multiple specialized departments including **Cardiology, Pediatrics, Neurology, Orthopedics, and Radiology**. This system replaces manual record-keeping with an enterprise-ready MySQL database.

### Key Features & Technical Highlights:
* **Database Normalization:** Fully normalized up to **Third Normal Form (3NF)** to ensure zero redundancy and data integrity.
* **Automated Room Management:** Real-time dynamic updates between `Available` and `Occupied` statuses via Triggers and Stored Procedures.
* **Schedule Collision Prevention:** Strict constraints and triggers preventing duplicate appointment slots for doctors.
* **Advanced RDBMS Architecture:** Integrated Views, Functions, Stored Procedures, and Triggers to support clinical and administrative reporting.

---

## 🗄️ Database Architecture

### Relational Schema Summary
1. **Department (1 : N) Doctor:** A single department employs multiple medical specialists.
2. **Doctor (1 : N) Appointment (N : 1) Patient:** Maps doctor availability with patient consultations.
3. **Patient (1 : N) Admission (N : 1) Room:** Tracks inpatient bed allocation and room stays.
4. **Room_Category (1 : N) Room:** Categorizes rooms (ICU, Private Room, General Ward) and tracks daily rates.
5. **Doctor (1 : N) Treatment / Lab_Test (N : 1) Patient:** Logs diagnoses, prescriptions, and lab diagnostic workflows.
6. **Patient (1 : N) Billing:** Centralized financial, invoice, and payment tracking.

---

## 💻 Database Objects & Features

### 1. Core Database Schema
* Contains strict relational enforcement: `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`, and `CHECK` constraints.
* **Tables:** `Department`, `Doctor`, `Patient`, `Appointment`, `Room_Category`, `Room`, `Admission`, `Treatment`, `Medicine`, `Prescription_Medicine`, `Lab_Test`, and `Billing`.

### 2. Views (`Task 07`)
* `vw_Patient_Medical_Summary`: Aggregates medical history, diagnoses, and prescriptions per patient.
* `vw_Active_Admissions`: Real-time operational view of current inpatients and occupied rooms.

### 3. Stored Procedures (`Task 08`)
* `sp_ScheduleAppointment`: Validates doctor schedules and reserves appointment slots.
* `sp_DischargePatient`: Automates patient discharge timestamps and releases room availability.

### 4. User-Defined Functions (`Task 09`)
* `fn_CalculateAdmissionCharge`: Dynamically calculates total stay cost based on room rate and elapsed days.
* `fn_GetPatientAge`: Computes patient age in years based on birthdate.

### 5. Triggers (`Task 10`)
* `trg_AfterAdmissionInsert`: Automatically updates room status to `Occupied` upon patient admission.
* `trg_BeforeAppointmentInsert`: Restricts booking appointments on past dates.

---

## 🛠️ Installation & Setup

### 1. Clone the Repository
```bash
git clone [https://github.com/MalithaDhananjaya/CCS1304-Data-Technologies-Group-Assignment.git](https://github.com/MalithaDhananjaya/CCS1304-Data-Technologies-Group-Assignment.git)
cd CCS1304-Data-Technologies-Group-Assignment


### 2. Import Database Scripts
Launch MySQL Workbench or your preferred SQL client.

Open and execute the provided .sql file:
Create DataBase/Database_Creation_&_Data_Insertion.sql

### 3. Verification Query
Run the following SQL snippet to verify successful setup:
USE SmartCareDB;
SELECT * FROM Patient;

## 📚 References & Academic Resources
Silberschatz, A., Korth, H. F., & Sudarshan, S. — Database System Concepts

Elmasri, R., & Navathe, S. B. — Fundamentals of Database Systems

MySQL 8.0 Reference Manual

GeeksforGeeks DBMS Tutorials
