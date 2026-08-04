
-- SmartCare Hospital Management System Database Script
-- Tasks: Task 04  & Task 05 


DROP DATABASE IF EXISTS SmartCareDB;
CREATE DATABASE SmartCareDB;
USE SmartCareDB;

-- 1. DEPARTMENT TABLE
CREATE TABLE Department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL
);

-- 2. DOCTOR TABLE
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    qualification VARCHAR(100) NOT NULL,
    specialization VARCHAR(100) NOT NULL,
    contact_number VARCHAR(15) NOT NULL UNIQUE,
    consultation_fee DECIMAL(10, 2) NOT NULL CHECK (consultation_fee > 0),
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES Department(department_id) ON DELETE CASCADE
);

-- 3. PATIENT TABLE
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    address TEXT NOT NULL,
    contact_number VARCHAR(15) NOT NULL UNIQUE,
    blood_group VARCHAR(5) NOT NULL
    emergency_contact VARCHAR(15)
);

-- 4. APPOINTMENT TABLE
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    consultation_room VARCHAR(20) NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id) ON DELETE CASCADE,
    CONSTRAINT unique_doctor_schedule UNIQUE (doctor_id, appointment_date, appointment_time)
);

-- 5. ROOM CATEGORY TABLE (Added to match ERD)
CREATE TABLE Room_Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    daily_rate DECIMAL(10, 2) NOT NULL CHECK (daily_rate >= 0)
);

-- 6. ROOM TABLE
CREATE TABLE Room (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    bed_number VARCHAR(10) NOT NULL UNIQUE,
    room_status ENUM('Available', 'Occupied', 'Maintenance') DEFAULT 'Available',
    FOREIGN KEY (category_id) REFERENCES Room_Category(category_id) ON DELETE CASCADE
);

-- 7. ADMISSION TABLE
CREATE TABLE Admission (
    admission_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    room_id INT NOT NULL,
    admission_date DATETIME NOT NULL,
    discharge_date DATETIME NULL,
    admission_status ENUM('Admitted', 'Discharged') DEFAULT 'Admitted',
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (room_id) REFERENCES Room(room_id) ON DELETE CASCADE
);

-- 8. TREATMENT TABLE
CREATE TABLE Treatment (
    treatment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    diagnosis TEXT NOT NULL,
    prescription TEXT NOT NULL,
    treatment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id) ON DELETE CASCADE
);

-- 9. LAB TEST TABLE
CREATE TABLE Lab_Test (
    lab_test_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL, -- Added to match Doctor -> Requests -> Lab_Test relationship
    test_name VARCHAR(100) NOT NULL,
    test_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    test_result TEXT,
    technician_name VARCHAR(100) NOT NULL,
    test_status ENUM('Pending', 'Completed') DEFAULT 'Pending',
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE,
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id) ON DELETE CASCADE
);

-- 10. BILLING TABLE
CREATE TABLE Billing (
    bill_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    bill_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL CHECK (total_amount >= 0),
    payment_status ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid',
    payment_method ENUM('Cash', 'Card', 'Online', 'Insurance') DEFAULT 'Cash',
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id) ON DELETE CASCADE
);

-- Task 05: Data Insertion (Minimum Requirements Satisfied)

-- Insert Departments 
INSERT INTO Department (dept_name, location) VALUES
('Cardiology', 'Building A - Floor 1'),
('Neurology', 'Building A - Floor 2'),
('Pediatrics', 'Building B - Floor 1'),
('Orthopedics', 'Building B - Floor 2'),
('Radiology', 'Building C - Ground Floor');

-- Insert Doctors
INSERT INTO Doctor (doctor_name, qualification, specialization, contact_number, consultation_fee, department_id) VALUES
('Dr. Sunil Perera', 'MBBS, MD (Cardiology)', 'Cardiologist', '0771234561', 3500.00, 1),
('Dr. Nimal Fernando', 'MBBS, MD (Neurology)', 'Neurologist', '0771234562', 4000.00, 2),
('Dr. Anusha Silva', 'MBBS, DCH', 'Pediatrician', '0771234563', 2500.00, 3),
('Dr. Kamalanathan S', 'MBBS, MS (Orth)', 'Orthopedic Surgeon', '0771234564', 3800.00, 4),
('Dr. Priyantha Jayasuriya', 'MBBS, MD (Radiology)', 'Radiologist', '0771234565', 3000.00, 5);


-- Insert Patients 
INSERT INTO Patient (full_name, dob, gender, address, contact_number, blood_group, emergency_contact) VALUES
('Kasun Kalhara', '1990-05-12', 'Male', 'Colombo 03', '0711111101', 'A+', '0719999901'),
('Ruwanthi De Silva', '1985-08-23', 'Female', 'Kandy', '0711111102', 'B+', '0719999902'),
('Saman Kumara', '1978-11-04', 'Male', 'Galle', '0711111103', 'O+', '0719999903'),
('Dilani Perera', '1995-02-15', 'Female', 'Negombo', '0711111104', 'AB+', '0719999904'),
('Mohomed Rizwan', '2001-09-30', 'Male', 'Gampaha', '0711111105', 'O-', '0719999905'),
('Chathuri Senanayake', '1992-12-10', 'Female', 'Kurunegala', '0711111106', 'A-', '0719999906'),
('Nuwan Pradeep', '1988-04-18', 'Male', 'Kalutara', '0711111107', 'B-', '0719999907'),
('Tharushi Jayawardena', '1998-07-07', 'Female', 'Ratnapura', '0711111108', 'AB-', '0719999908'),
('Mahesh Wickramasinghe', '1965-01-25', 'Male', 'Matara', '0711111109', 'O+', '0719999909'),
('Kavindi Bandara', '2005-03-14', 'Female', 'Anuradhapura', '0711111110', 'A+', '0719999910');

-- Insert Rooms
INSERT INTO Room (room_category, bed_number, is_available) VALUES
('ICU', 'ICU-01', FALSE),
('ICU', 'ICU-02', TRUE),
('Private Room', 'PR-101', FALSE),
('Private Room', 'PR-102', TRUE),
('General Ward', 'GW-201', TRUE),
('General Ward', 'GW-202', TRUE);

-- Insert Appointments 
INSERT INTO Appointment (patient_id, doctor_id, appointment_date, appointment_time, status, consultation_room) VALUES
(1, 1, '2026-07-01', '09:00:00', 'Completed', 'Room 101'),
(1, 2, '2026-07-05', '10:00:00', 'Completed', 'Room 102'),
(2, 1, '2026-07-01', '09:30:00', 'Completed', 'Room 101'),
(3, 3, '2026-07-02', '10:00:00', 'Completed', 'Room 103'),
(4, 4, '2026-07-02', '11:00:00', 'Completed', 'Room 104'),
(5, 5, '2026-07-03', '08:30:00', 'Completed', 'Room 105'),
(6, 1, '2026-07-03', '09:00:00', 'Scheduled', 'Room 101'),
(7, 2, '2026-07-04', '14:00:00', 'Scheduled', 'Room 102'),
(8, 3, '2026-07-04', '15:00:00', 'Scheduled', 'Room 103'),
(9, 4, '2026-07-05', '09:00:00', 'Scheduled', 'Room 104'),
(10, 5, '2026-07-05', '10:30:00', 'Scheduled', 'Room 105'),
(1, 4, '2026-07-10', '11:30:00', 'Scheduled', 'Room 104'),
(2, 3, '2026-07-11', '09:00:00', 'Scheduled', 'Room 103'),
(3, 1, '2026-07-12', '10:00:00', 'Scheduled', 'Room 101'),
(5, 2, '2026-07-12', '11:00:00', 'Scheduled', 'Room 102');

-- Insert Admissions
INSERT INTO Admission (patient_id, room_id, admission_date, discharge_date, admission_status) VALUES
(3, 1, '2026-07-01 10:00:00', NULL, 'Admitted'),
(5, 3, '2026-07-02 11:30:00', NULL, 'Admitted');

-- Insert Lab Tests
INSERT INTO Lab_Test (patient_id, test_name, test_date, test_result, technician_name, test_status) VALUES
(1, 'ECG Report', '2026-07-01 09:45:00', 'Normal Sinus Rhythm', 'Sunil Shantha', 'Completed'),
(3, 'Blood Count (FBC)', '2026-07-01 11:00:00', 'WBC slightly elevated', 'Kamal Perera', 'Completed'),
(5, 'MRI Brain Scan', '2026-07-02 14:00:00', 'Pending evaluation', 'Nimali Fonseka', 'Pending');

-- Insert Billing Records 
INSERT INTO Billing (patient_id, bill_date, consultation_charges, room_charges, lab_charges, medicine_charges, total_amount, payment_status, payment_method) VALUES
(1, '2026-07-01 10:30:00', 3500.00, 0.00, 1500.00, 2000.00, 7000.00, 'Paid', 'Cash'),
(2, '2026-07-01 10:00:00', 3500.00, 0.00, 0.00, 1200.00, 4700.00, 'Paid', 'Card'),
(3, '2026-07-02 12:00:00', 2500.00, 15000.00, 3000.00, 4500.00, 25000.00, 'Unpaid', 'Cash'),
(4, '2026-07-02 11:45:00', 3800.00, 0.00, 0.00, 800.00, 4600.00, 'Paid', 'Online'),
(5, '2026-07-03 09:15:00', 3000.00, 8000.00, 12000.00, 3500.00, 26500.00, 'Unpaid', 'Insurance'),
(6, '2026-07-03 09:30:00', 3500.00, 0.00, 0.00, 500.00, 4000.00, 'Paid', 'Cash'),
(7, '2026-07-04 14:30:00', 4000.00, 0.00, 0.00, 1500.00, 5500.00, 'Unpaid', 'Card'),
(8, '2026-07-04 15:30:00', 2500.00, 0.00, 2000.00, 1000.00, 5500.00, 'Paid', 'Cash'),
(9, '2026-07-05 09:30:00', 3800.00, 0.00, 0.00, 2200.00, 6000.00, 'Paid', 'Online'),
(10, '2026-07-05 11:00:00', 3000.00, 0.00, 1800.00, 1200.00, 6000.00, 'Unpaid', 'Cash');

