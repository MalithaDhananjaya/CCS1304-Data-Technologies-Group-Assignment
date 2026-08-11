DROP DATABASE IF EXISTS SmartCareDB;
CREATE DATABASE SmartCareDB;
USE SmartCareDB;

-- 01. DEPARTMENT TABLE
CREATE TABLE Department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL UNIQUE,
    location VARCHAR(100) NOT NULL,
    head_doctor_id INT NULL
);

-- 02. DOCTOR TABLE
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

-- Add Foreign Key for Department Head Doctor
ALTER TABLE Department 
ADD CONSTRAINT fk_head_doctor 
FOREIGN KEY (head_doctor_id) REFERENCES Doctor(doctor_id) ON DELETE SET NULL;

-- 03. PATIENT TABLE
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    address TEXT NOT NULL,
    contact_number VARCHAR(15) NOT NULL UNIQUE,
    emergency_contact VARCHAR(15) NOT NULL,
    blood_group VARCHAR(5) NOT NULL
);

-- 04. APPOINTMENT TABLE
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

-- 05. ROOM CATEGORY & ROOM TABLES
CREATE TABLE Room_Category (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL UNIQUE,
    daily_rate DECIMAL(10, 2) NOT NULL CHECK (daily_rate >= 0)
);

-- 06. ROOM TABLES
CREATE TABLE Room (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    bed_number VARCHAR(10) NOT NULL UNIQUE,
    room_status ENUM('Available', 'Occupied', 'Maintenance') DEFAULT 'Available',
    FOREIGN KEY (category_id) REFERENCES Room_Category(category_id) ON DELETE CASCADE
);

-- 07. ADMISSION TABLE
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

-- 08. TREATMENT & MEDICINE TABLES
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

CREATE TABLE Medicine (
    medicine_id INT AUTO_INCREMENT PRIMARY KEY,
    medicine_name VARCHAR(100) NOT NULL UNIQUE,
    unit_price DECIMAL(10, 2) NOT NULL CHECK (unit_price >= 0)
);

CREATE TABLE Prescription_Medicine (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    treatment_id INT NOT NULL,
    medicine_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    FOREIGN KEY (treatment_id) REFERENCES Treatment(treatment_id) ON DELETE CASCADE,
    FOREIGN KEY (medicine_id) REFERENCES Medicine(medicine_id) ON DELETE CASCADE
);

-- 09. LAB TEST TABLE
CREATE TABLE Lab_Test (
    lab_test_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    test_name VARCHAR(100) NOT NULL,
    test_fee DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
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


-- DATA INSERTIONS
INSERT INTO Department (dept_name, location) VALUES
('Cardiology', 'Building A - Floor 1'),
('Neurology', 'Building A - Floor 2'),
('Pediatrics', 'Building B - Floor 1'),
('Orthopedics', 'Building B - Floor 2'),
('Radiology', 'Building C - Ground Floor');

INSERT INTO Doctor (doctor_name, qualification, specialization, contact_number, consultation_fee, department_id) VALUES
('Dr. Sunil Perera', 'MBBS, MD (Cardiology)', 'Cardiologist', '0771234561', 3500.00, 1),
('Dr. Nimal Fernando', 'MBBS, MD (Neurology)', 'Neurologist', '0771234562', 4000.00, 2),
('Dr. Anusha Silva', 'MBBS, DCH', 'Pediatrician', '0771234563', 2500.00, 3),
('Dr. Kamalanathan S', 'MBBS, MS (Orth)', 'Orthopedic Surgeon', '0771234564', 3800.00, 4),
('Dr. Priyantha Jayasuriya', 'MBBS, MD (Radiology)', 'Radiologist', '0771234565', 3000.00, 5);

UPDATE Department SET head_doctor_id = 1 WHERE department_id = 1;
UPDATE Department SET head_doctor_id = 2 WHERE department_id = 2;
UPDATE Department SET head_doctor_id = 3 WHERE department_id = 3;
UPDATE Department SET head_doctor_id = 4 WHERE department_id = 4;
UPDATE Department SET head_doctor_id = 5 WHERE department_id = 5;

INSERT INTO Patient (full_name, dob, gender, address, contact_number, emergency_contact, blood_group) VALUES
('Kasun Kalhara', '1990-05-12', 'Male', 'Colombo 03', '0711111101', '0779999901', 'A+'),
('Ruwanthi De Silva', '1985-08-23', 'Female', 'Kandy', '0711111102', '0779999902', 'B+'),
('Saman Kumara', '1978-11-04', 'Male', 'Galle', '0711111103', '0779999903', 'O+'),
('Dilani Perera', '1995-02-15', 'Female', 'Negombo', '0711111104', '0779999904', 'AB+'),
('Mohomed Rizwan', '2001-09-30', 'Male', 'Gampaha', '0711111105', '0779999905', 'O-'),
('Chathuri Senanayake', '1992-12-10', 'Female', 'Kurunegala', '0711111106', '0779999906', 'A-'),
('Nuwan Pradeep', '1988-04-18', 'Male', 'Kalutara', '0711111107', '0779999907', 'B-'),
('Tharushi Jayawardena', '1998-07-07', 'Female', 'Ratnapura', '0711111108', '0779999908', 'AB-'),
('Mahesh Wickramasinghe', '1965-01-25', 'Male', 'Matara', '0711111109', '0779999909', 'O+'),
('Kavindi Bandara', '2005-03-14', 'Female', 'Anuradhapura', '0711111110', '0779999910', 'A+');

INSERT INTO Room_Category (category_name, daily_rate) VALUES
('ICU', 15000.00), ('Private Room', 8000.00), ('General Ward', 3000.00);

INSERT INTO Room (category_id, bed_number, room_status) VALUES
(1, 'ICU-01', 'Occupied'), (1, 'ICU-02', 'Available'),
(2, 'PR-101', 'Occupied'), (2, 'PR-102', 'Available'),
(3, 'GW-201', 'Available'), (3, 'GW-202', 'Available');

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

INSERT INTO Admission (patient_id, room_id, admission_date, discharge_date, admission_status) VALUES
(3, 1, '2026-07-01 10:00:00', NULL, 'Admitted'),
(5, 3, '2026-07-02 11:30:00', NULL, 'Admitted');

INSERT INTO Lab_Test (patient_id, doctor_id, test_name, test_fee, test_date, test_result, technician_name, test_status) VALUES
(1, 1, 'ECG Report', 3500.00, '2026-07-01 09:45:00', 'Normal Sinus Rhythm', 'Sunil Shantha', 'Completed'),
(3, 1, 'Blood Count (FBC)', 1500.00, '2026-07-01 11:00:00', 'WBC slightly elevated', 'Kamal Perera', 'Completed'),
(5, 2, 'MRI Brain Scan', 18500.00, '2026-07-02 14:00:00', 'Pending evaluation', 'Nimali Fonseka', 'Pending');

INSERT INTO Billing (patient_id, bill_date, total_amount, payment_status, payment_method) VALUES
(1, '2026-07-01 10:30:00', 7000.00, 'Paid', 'Cash'),
(2, '2026-07-01 10:00:00', 4700.00, 'Paid', 'Card'),
(3, '2026-07-02 12:00:00', 25000.00, 'Unpaid', 'Cash'),
(4, '2026-07-02 11:45:00', 4600.00, 'Paid', 'Online'),
(5, '2026-07-03 09:15:00', 26500.00, 'Unpaid', 'Insurance'),
(6, '2026-07-03 09:30:00', 4000.00, 'Paid', 'Cash'),
(7, '2026-07-04 14:30:00', 5500.00, 'Unpaid', 'Card'),
(8, '2026-07-04 15:30:00', 5500.00, 'Paid', 'Cash'),
(9, '2026-07-05 09:30:00', 6000.00, 'Paid', 'Online'),
(10, '2026-07-05 11:00:00', 6000.00, 'Unpaid', 'Cash');