# 📊 Database Design Documentation

## Student Information System (SIS) - EMS Database

**Version:** 2.3.0  
**Database:** MySQL 8.0+ / MariaDB 10.5+  
**Character Set:** UTF8MB4  
**Last Updated:** January 15, 2026

---

## 📋 Table of Contents

1. [Overview](#overview)
2. [Entity Relationship Diagram](#entity-relationship-diagram)
3. [Table Descriptions](#table-descriptions)
4. [Foreign Key Relationships](#foreign-key-relationships)
5. [Views](#views)
6. [Stored Procedures](#stored-procedures)
7. [Functions](#functions)
8. [Triggers](#triggers)
9. [Constraints](#constraints)
10. [Indexes](#indexes)
11. [Grade Scale Reference](#grade-scale-reference)

---

## Overview

The EMS (Enrollment Management System) database is designed to manage:
- Student information and academic records
- Course curriculum and class schedules
- Enrollment tracking across academic terms
- Payment and financial transactions
- Faculty/instructor management
- System user authentication

### Database Statistics

| Component | Count |
|-----------|-------|
| Tables | 14 |
| Views | 12 |
| Stored Procedures | 20 |
| Functions | 2 |
| Triggers | 3 |
| CHECK Constraints | 4 |

---

## Entity Relationship Diagram

### Visual ERD (All 18 Foreign Key Relationships)

```
                                    ┌─────────────────┐
                                    │   DEPARTMENTS   │
                                    │ (department_id) │
                                    └────────┬────────┘
                                             │
              ┌──────────────────────────────┼──────────────────────────────┐
              │                              │                              │
              ▼                              ▼                              ▼
       ┌─────────────┐               ┌─────────────┐                ┌─────────────┐
       │  PROGRAMS   │               │ INSTRUCTORS │                │    USERS    │
       │(program_id) │               │(instructor_ │                │  (user_id)  │
       └──────┬──────┘               │    id)      │                └──────┬──────┘
              │                      └──────┬──────┘                       │
              │                             │                              │
     ┌────────┼────────┐                    │                              │
     │        │        │                    │                              │
     ▼        │        ▼                    │                              │
┌──────────┐  │  ┌──────────┐               │                              │
│CURRICULUM│  │  │ STUDENTS │               │                              │
│(curricul │  │  │(student_ │               │                              │
│  um_id)  │  │  │   id)    │               │                              │
└────┬─────┘  │  └────┬─────┘               │                              │
     │        │       │                     │                              │
     │        │  ┌────┴─────┬───────────────┼──────────────────────────────┤
     │        │  │          │               │                              │
     │        │  │          ▼               │                              │
     │        │  │   ┌─────────────┐        │                              │
     │        │  │   │  STUDENT_   │        │                              │
     │        │  │   │  PROGRAMS   │        │                              │
     │        │  │   │(student_    │        │                              │
     │        │  │   │ program_id) │        │                              │
     │        │  │   └──────┬──────┘        │                              │
     │        │  │          │               │                              │
     │        └──┼──────────┼───────────────┼──────────────┐               │
     │           │          │               │              │               │
     │           │          ▼               │              │               │
     │           │   ┌─────────────┐        │              │               │
     │           │   │  ACADEMIC_  │◄───────┼──────────────┼───────────────┤
     │           │   │   YEARS     │        │              │               │
     │           │   │(academic_   │        │              │               │
     │           │   │  year_id)   │        │              │               │
     │           │   └──────┬──────┘        │              │               │
     │           │          │               │              │               │
     │           │          │               │              ▼               │
     │           ▼          ▼               │       ┌─────────────┐        │
     │    ┌─────────────────────────┐       │       │  PAYMENTS   │◄───────┘
     └───►│      ENROLLMENTS        │◄──────┘       │(payment_id) │
          │    (enrollment_id)      │               └──────┬──────┘
          └───────────┬─────────────┘                      ▲
                      │                                    │
                      ▼                                    │
               ┌─────────────┐                      ┌──────┴──────┐
               │   CLASS_    │                      │PAYMENT_TYPES│
               │ SCHEDULES   │                      │(payment_    │
               │(schedule_id)│                      │  type_id)   │
               └─────────────┘                      └─────────────┘


    STANDALONE TABLES (No Foreign Keys):
    ┌─────────────┐     ┌─────────────┐
    │ GRADE_SCALE │     │  AUDIT_LOG  │
    │ (reference) │     │  (logging)  │
    └─────────────┘     └─────────────┘
```

### Relationship Legend

```
Symbol    Meaning
──────    ────────────────────────────────────────────────
  │       Connection line
  ▼       Foreign Key direction (points to PARENT table)
  ◄       Foreign Key direction (points to PARENT table)

Example:
  PROGRAMS ──▼──► DEPARTMENTS
  Means: programs.department_id REFERENCES departments.department_id
```

### Foreign Key Summary by Table

```
DEPARTMENTS (Root - No FK)
    ▲
    ├── PROGRAMS.department_id
    ├── INSTRUCTORS.department_id
    └── USERS.department_id

PROGRAMS
    ▲
    ├── CURRICULUM.program_id
    ├── STUDENTS.current_program_id
    └── STUDENT_PROGRAMS.program_id

STUDENTS
    ▲
    ├── STUDENT_PROGRAMS.student_id
    ├── ENROLLMENTS.student_id
    └── PAYMENTS.student_id

ACADEMIC_YEARS
    ▲
    ├── STUDENT_PROGRAMS.academic_year_id
    ├── ENROLLMENTS.academic_year_id
    └── PAYMENTS.academic_year_id

INSTRUCTORS
    ▲
    ├── ENROLLMENTS.instructor_id
    └── CLASS_SCHEDULES.instructor_id

CURRICULUM
    ▲
    └── ENROLLMENTS.curriculum_id

ENROLLMENTS
    ▲
    └── CLASS_SCHEDULES.enrollment_id

PAYMENT_TYPES
    ▲
    └── PAYMENTS.payment_type_id

USERS
    ▲
    └── PAYMENTS.processed_by
```

---

## Table Descriptions

### Core Tables

#### 1. `departments`
Academic departments and colleges.

| Column | Type | Description |
|--------|------|-------------|
| `department_id` | INT UNSIGNED | Primary Key (Auto-increment) |
| `department_code` | VARCHAR(20) | Unique code (e.g., CCS, COE) |
| `department_name` | VARCHAR(150) | Full department name |
| `college` | VARCHAR(150) | College name |
| `dean_name` | VARCHAR(100) | Department dean |
| `contact_email` | VARCHAR(100) | Contact email |
| `contact_phone` | VARCHAR(20) | Contact phone |
| `office_location` | VARCHAR(100) | Office location |
| `is_active` | BOOLEAN | Active status |
| `created_at` | TIMESTAMP | Record creation time |
| `updated_at` | TIMESTAMP | Last update time |

---

#### 2. `programs`
Academic degree programs.

| Column | Type | Description |
|--------|------|-------------|
| `program_id` | INT UNSIGNED | Primary Key |
| `program_code` | VARCHAR(20) | Unique code (e.g., BSIT, BSCS) |
| `program_name` | VARCHAR(150) | Full program name |
| `department_id` | INT UNSIGNED | FK → departments |
| `degree_type` | ENUM | Certificate, Associate, Bachelor, Master, Doctorate |
| `description` | TEXT | Program description |
| `total_units` | INT UNSIGNED | Required units for graduation |
| `years_duration` | TINYINT UNSIGNED | Program duration in years |
| `is_active` | BOOLEAN | Active status |
| `accreditation_status` | ENUM | None, Candidate, Level I-IV |

---

#### 3. `academic_years`
Academic year and term management.

| Column | Type | Description |
|--------|------|-------------|
| `academic_year_id` | INT UNSIGNED | Primary Key |
| `academic_year` | VARCHAR(20) | Format: YYYY-YYYY |
| `semester` | ENUM | 1st Semester, 2nd Semester, Summer |
| `start_date` | DATE | Term start date |
| `end_date` | DATE | Term end date |
| `enrollment_start` | DATE | Enrollment period start |
| `enrollment_end` | DATE | Enrollment period end |
| `is_current` | BOOLEAN | Current active term |
| `status` | ENUM | Upcoming, Enrollment, Ongoing, Finals, Completed |

---

#### 4. `curriculum`
Course/subject offerings per program.

| Column | Type | Description |
|--------|------|-------------|
| `curriculum_id` | INT UNSIGNED | Primary Key |
| `course_code` | VARCHAR(20) | Course code (e.g., CC101) |
| `course_name` | VARCHAR(150) | Course name |
| `description` | TEXT | Course description |
| `units` | TINYINT UNSIGNED | Total units |
| `lecture_units` | TINYINT UNSIGNED | Lecture units |
| `lab_units` | TINYINT UNSIGNED | Laboratory units |
| `lecture_hours` | TINYINT UNSIGNED | Lecture hours per week |
| `lab_hours` | TINYINT UNSIGNED | Lab hours per week |
| `program_id` | INT UNSIGNED | FK → programs |
| `year_level` | ENUM | 1st-5th Year |
| `semester` | ENUM | 1st Semester, 2nd Semester, Summer |
| `course_type` | ENUM | Core, Major, Minor, Elective, GE, NSTP, PE |
| `prerequisites` | VARCHAR(255) | Comma-separated prerequisite codes |
| `corequisites` | VARCHAR(255) | Corequisite courses |
| `is_active` | BOOLEAN | Active status |
| `effective_year` | VARCHAR(20) | Curriculum effective year |

---

#### 5. `instructors`
Faculty members and instructors.

| Column | Type | Description |
|--------|------|-------------|
| `instructor_id` | INT UNSIGNED | Primary Key |
| `employee_id` | VARCHAR(20) | Format: EMP-YYYY-XXXXX |
| `first_name` | VARCHAR(50) | First name |
| `middle_name` | VARCHAR(50) | Middle name |
| `last_name` | VARCHAR(50) | Last name |
| `suffix` | VARCHAR(10) | Name suffix |
| `title` | VARCHAR(30) | Prof., Dr., Engr., etc. |
| `email` | VARCHAR(100) | Email (unique) |
| `phone` | VARCHAR(20) | Contact phone |
| `office_location` | VARCHAR(100) | Office location |
| `department_id` | INT UNSIGNED | FK → departments |
| `position` | ENUM | Instructor to Dean |
| `specialization` | VARCHAR(255) | Areas of expertise |
| `employment_status` | ENUM | Full-time, Part-time, etc. |
| `is_active` | BOOLEAN | Active status |

---

#### 6. `students`
Student master records.

| Column | Type | Description |
|--------|------|-------------|
| `student_id` | INT UNSIGNED | Primary Key (Auto-increment) |
| `student_number` | VARCHAR(20) | Format: STU-YYYY-XXXXX (Unique) |
| `first_name` | VARCHAR(50) | First name |
| `middle_name` | VARCHAR(50) | Middle name |
| `last_name` | VARCHAR(50) | Last name |
| `suffix` | VARCHAR(10) | Name suffix |
| `sex` | ENUM | Male, Female |
| `civil_status` | ENUM | Single, Married, etc. |
| `nationality` | VARCHAR(50) | Default: Filipino |
| `religion` | VARCHAR(50) | Religion |
| `blood_type` | ENUM | A+, A-, B+, B-, AB+, AB-, O+, O-, Unknown |
| `email` | VARCHAR(100) | Email (unique) |
| `phone` | VARCHAR(20) | Contact phone |
| `date_of_birth` | DATE | Birth date |
| `place_of_birth` | VARCHAR(100) | Birth place |
| `address_street` | VARCHAR(255) | Street address |
| `address_barangay` | VARCHAR(100) | Barangay |
| `address_city` | VARCHAR(100) | City/Municipality |
| `address_province` | VARCHAR(100) | Province |
| `address_zip` | VARCHAR(10) | ZIP code |
| `permanent_address` | TEXT | Permanent address |
| `guardian_name` | VARCHAR(100) | Guardian name |
| `guardian_relationship` | ENUM | Father, Mother, Guardian, etc. |
| `guardian_contact` | VARCHAR(20) | Guardian phone |
| `guardian_email` | VARCHAR(100) | Guardian email |
| `guardian_occupation` | VARCHAR(100) | Guardian occupation |
| `guardian_address` | VARCHAR(255) | Guardian address |
| `emergency_contact_name` | VARCHAR(100) | Emergency contact |
| `emergency_contact_phone` | VARCHAR(20) | Emergency phone |
| `emergency_contact_relationship` | VARCHAR(50) | Relationship |
| `current_program_id` | INT UNSIGNED | FK → programs |
| `admission_date` | DATE | Admission date |
| `admission_type` | ENUM | Freshman, Transferee, etc. |
| `year_level` | ENUM | 1st-5th Year |
| `current_semester` | ENUM | 1st Semester, 2nd Semester, Summer |
| `section` | VARCHAR(20) | Section assignment |
| `student_status` | ENUM | Active, Inactive, Graduated, etc. |
| `scholarship_status` | ENUM | None, Partial, Full, etc. |
| `profile_photo` | VARCHAR(255) | Photo file path |
| `lrn` | VARCHAR(20) | Learner Reference Number |

---

#### 7. `student_programs`
Student program enrollment history (for transfers/shifts).

| Column | Type | Description |
|--------|------|-------------|
| `student_program_id` | INT UNSIGNED | Primary Key |
| `student_id` | INT UNSIGNED | FK → students |
| `program_id` | INT UNSIGNED | FK → programs |
| `academic_year_id` | INT UNSIGNED | FK → academic_years |
| `action` | ENUM | Enrolled, Shifted, Transferred, etc. |
| `effective_date` | DATE | Effective date |
| `remarks` | TEXT | Additional notes |

---

#### 8. `enrollments`
Student course enrollments per term.

| Column | Type | Description |
|--------|------|-------------|
| `enrollment_id` | INT UNSIGNED | Primary Key |
| `student_id` | INT UNSIGNED | FK → students |
| `curriculum_id` | INT UNSIGNED | FK → curriculum |
| `academic_year_id` | INT UNSIGNED | FK → academic_years |
| `enrollment_date` | DATE | Enrollment date |
| `enrollment_status` | ENUM | Enrolled, Dropped, Withdrawn, Cancelled |
| `midterm_grade` | DECIMAL(3,2) | Midterm grade (1.00-5.00) |
| `final_grade` | DECIMAL(3,2) | Final grade (1.00-5.00) |
| `grade` | DECIMAL(3,2) | Final computed grade |
| `grade_status` | ENUM | Pending, Passed, Failed, etc. |
| `grade_remarks` | VARCHAR(100) | Grade remarks |
| `instructor_id` | INT UNSIGNED | FK → instructors |
| `remarks` | TEXT | Additional notes |

**CHECK Constraints:**
- `midterm_grade`: 1.00-5.00 or NULL
- `final_grade`: 1.00-5.00 or NULL
- `grade`: 1.00-5.00 or NULL

---

#### 9. `class_schedules`
Weekly class schedules per enrollment.

| Column | Type | Description |
|--------|------|-------------|
| `schedule_id` | INT UNSIGNED | Primary Key |
| `enrollment_id` | INT UNSIGNED | FK → enrollments |
| `day_of_week` | ENUM | Monday-Sunday |
| `start_time` | TIME | Class start time |
| `end_time` | TIME | Class end time |
| `room` | VARCHAR(50) | Room number |
| `building` | VARCHAR(100) | Building name |
| `instructor_id` | INT UNSIGNED | FK → instructors (override) |
| `class_type` | ENUM | Lecture, Laboratory, etc. |
| `is_active` | BOOLEAN | Active status |
| `notes` | TEXT | Schedule notes |

**CHECK Constraints:**
- `end_time > start_time`

---

#### 10. `payment_types`
Fee categories and types.

| Column | Type | Description |
|--------|------|-------------|
| `payment_type_id` | INT UNSIGNED | Primary Key |
| `type_code` | VARCHAR(20) | Unique code |
| `type_name` | VARCHAR(100) | Type name |
| `description` | TEXT | Description |
| `category` | ENUM | Tuition, Laboratory, Miscellaneous, Other |
| `default_amount` | DECIMAL(12,2) | Default amount |
| `is_mandatory` | BOOLEAN | Required fee |
| `is_active` | BOOLEAN | Active status |

---

#### 11. `payments`
Student payment transactions.

| Column | Type | Description |
|--------|------|-------------|
| `payment_id` | INT UNSIGNED | Primary Key |
| `student_id` | INT UNSIGNED | FK → students |
| `payment_type_id` | INT UNSIGNED | FK → payment_types |
| `academic_year_id` | INT UNSIGNED | FK → academic_years |
| `description` | VARCHAR(255) | Payment description |
| `amount_due` | DECIMAL(12,2) | Amount due |
| `amount_paid` | DECIMAL(12,2) | Amount paid |
| `balance` | DECIMAL(12,2) | **GENERATED** (amount_due - amount_paid) |
| `payment_date` | DATE | Payment date |
| `due_date` | DATE | Due date |
| `payment_method` | ENUM | Cash, Bank Transfer, Online, etc. |
| `reference_number` | VARCHAR(100) | Transaction reference |
| `payment_status` | ENUM | Unpaid, Partial, Paid, Overdue, etc. |
| `processed_by` | INT UNSIGNED | FK → users |
| `remarks` | TEXT | Payment remarks |

---

#### 12. `users`
System users for authentication.

| Column | Type | Description |
|--------|------|-------------|
| `user_id` | INT UNSIGNED | Primary Key |
| `username` | VARCHAR(50) | Username (unique) |
| `email` | VARCHAR(100) | Email (unique) |
| `password` | VARCHAR(255) | bcrypt hashed password |
| `full_name` | VARCHAR(100) | Full name |
| `role` | ENUM | Super Admin, Admin, Registrar, etc. |
| `department_id` | INT UNSIGNED | FK → departments |
| `is_active` | BOOLEAN | Active status |
| `is_verified` | BOOLEAN | Email verified |
| `last_login` | DATETIME | Last login time |
| `last_password_change` | DATETIME | Last password change |
| `failed_login_attempts` | TINYINT UNSIGNED | Failed attempts count |
| `locked_until` | DATETIME | Account lock expiry |
| `remember_token` | VARCHAR(255) | Remember me token |
| `reset_token` | VARCHAR(255) | Password reset token |
| `reset_token_expires` | DATETIME | Reset token expiry |

---

### Reference Tables

#### 13. `grade_scale`
Philippine grading system reference.

| Column | Type | Description |
|--------|------|-------------|
| `grade_scale_id` | INT UNSIGNED | Primary Key |
| `grade_value` | DECIMAL(3,2) | Grade value (1.00-5.00) |
| `grade_equivalent` | VARCHAR(20) | Grade string |
| `description` | VARCHAR(100) | Description (Excellent, Good, etc.) |
| `grade_point` | DECIMAL(3,2) | GPA equivalent |
| `is_passing` | BOOLEAN | Passing grade flag |

---

#### 14. `audit_log`
Track important data changes.

| Column | Type | Description |
|--------|------|-------------|
| `audit_id` | BIGINT UNSIGNED | Primary Key |
| `table_name` | VARCHAR(64) | Affected table |
| `record_id` | INT UNSIGNED | Affected record ID |
| `action` | ENUM | INSERT, UPDATE, DELETE |
| `old_values` | JSON | Previous values |
| `new_values` | JSON | New values |
| `changed_by` | INT UNSIGNED | FK → users |
| `changed_at` | TIMESTAMP | Change timestamp |
| `ip_address` | VARCHAR(45) | Client IP |
| `user_agent` | VARCHAR(255) | Browser/client info |

---

## Foreign Key Relationships

| Child Table | FK Column | → | Parent Table | Parent Column | ON DELETE | ON UPDATE |
|-------------|-----------|---|--------------|---------------|-----------|-----------|
| `programs` | `department_id` | → | `departments` | `department_id` | SET NULL | CASCADE |
| `instructors` | `department_id` | → | `departments` | `department_id` | SET NULL | CASCADE |
| `users` | `department_id` | → | `departments` | `department_id` | SET NULL | CASCADE |
| `curriculum` | `program_id` | → | `programs` | `program_id` | CASCADE | CASCADE |
| `students` | `current_program_id` | → | `programs` | `program_id` | SET NULL | CASCADE |
| `student_programs` | `student_id` | → | `students` | `student_id` | CASCADE | CASCADE |
| `student_programs` | `program_id` | → | `programs` | `program_id` | RESTRICT | CASCADE |
| `student_programs` | `academic_year_id` | → | `academic_years` | `academic_year_id` | RESTRICT | CASCADE |
| `enrollments` | `student_id` | → | `students` | `student_id` | CASCADE | CASCADE |
| `enrollments` | `curriculum_id` | → | `curriculum` | `curriculum_id` | RESTRICT | CASCADE |
| `enrollments` | `academic_year_id` | → | `academic_years` | `academic_year_id` | RESTRICT | CASCADE |
| `enrollments` | `instructor_id` | → | `instructors` | `instructor_id` | SET NULL | CASCADE |
| `class_schedules` | `enrollment_id` | → | `enrollments` | `enrollment_id` | CASCADE | CASCADE |
| `class_schedules` | `instructor_id` | → | `instructors` | `instructor_id` | SET NULL | CASCADE |
| `payments` | `student_id` | → | `students` | `student_id` | CASCADE | CASCADE |
| `payments` | `payment_type_id` | → | `payment_types` | `payment_type_id` | SET NULL | CASCADE |
| `payments` | `academic_year_id` | → | `academic_years` | `academic_year_id` | RESTRICT | CASCADE |
| `payments` | `processed_by` | → | `users` | `user_id` | SET NULL | CASCADE |

---

## Views

| View Name | Description |
|-----------|-------------|
| `vw_student_enrollment_summary` | Student enrollment overview with units |
| `vw_student_balance` | Student payment balance per term |
| `vw_curriculum_overview` | Curriculum with program and department |
| `vw_class_schedule` | Class schedule with student and instructor |
| `vw_departments` | Departments with program count |
| `vw_payment_types` | Active payment types |
| `vw_student_program_history` | Student program transfer history |
| `vw_instructor_workload` | Instructor class and student counts |
| `vw_enrollment_grades` | Enrollment grades with all details |
| `vw_student_full_profile` | Complete student profile with balance |
| `vw_active_enrollments` | Current term enrollments only |
| `vw_student_gpa` | Student GPA and academic standing |

---

## Stored Procedures

### Student Operations
| Procedure | Parameters | Description |
|-----------|------------|-------------|
| `sp_get_student_profile` | `p_student_id` | Get complete student profile |
| `sp_get_student_enrollments` | `p_student_id` | Get student enrollment history |
| `sp_get_student_schedule` | `p_student_id` | Get student class schedule |
| `sp_get_student_payments` | `p_student_id` | Get student payment history |
| `sp_get_student_programs` | `p_student_id` | Get student program history |
| `sp_search_students` | `search, program_id, year_level, status, limit, offset` | Search students with filters |

### Payment Operations
| Procedure | Parameters | Description |
|-----------|------------|-------------|
| `sp_record_payment` | `student_id, payment_type_id, academic_year_id, amount_due, amount_paid, payment_date, due_date, payment_method, reference_number, processed_by, description, remarks` | Record validated payment transaction |
| `sp_get_payment_stats` | `p_academic_year_id` | Get payment statistics by status (for dashboard) |
| `sp_update_overdue_payments` | (none) | Batch update overdue payment statuses (run daily) |

### Enrollment Operations
| Procedure | Parameters | Description |
|-----------|------------|-------------|
| `sp_validate_prerequisites` | `p_student_id, p_curriculum_id` | Check if prerequisites are met |
| `sp_enroll_student_with_validation` | `p_student_id, p_curriculum_id, p_academic_year_id, p_enrollment_date, p_instructor_id` | Enroll with prerequisite check |
| `sp_get_course_roster` | `p_curriculum_id, p_academic_year_id` | Get all students in a course |
| `sp_check_schedule_conflict` | `p_student_id, p_academic_year_id, p_day, p_start, p_end` | Check for schedule conflicts |

### Administrative Operations
| Procedure | Parameters | Description |
|-----------|------------|-------------|
| `sp_get_users` | (none) | Get all system users |
| `sp_get_instructor_schedule` | `p_instructor_id` | Get instructor schedule |
| `sp_get_academic_statistics` | (none) | Get dashboard statistics |
| `sp_set_current_academic_year` | `p_academic_year_id` | Set current academic term |

### Maintenance Operations
| Procedure | Parameters | Description |
|-----------|------------|-------------|
| `sp_check_data_integrity` | (none) | Check for orphan records |
| `sp_get_database_stats` | (none) | Get table row counts |
| `sp_log_audit` | `p_table, p_record_id, p_action, p_old, p_new, p_user_id` | Log audit entry |

---

## Functions

| Function | Parameters | Returns | Description |
|----------|------------|---------|-------------|
| `fn_calculate_gpa` | `p_student_id, p_academic_year_id` | DECIMAL(4,3) | Calculate semester GPA |
| `fn_calculate_cumulative_gpa` | `p_student_id` | DECIMAL(4,3) | Calculate overall GPA |

---

## Triggers

| Trigger | Table | Event | Description |
|---------|-------|-------|-------------|
| `trg_payment_before_insert` | `payments` | BEFORE INSERT | Auto-update payment status based on priority |
| `trg_payment_before_update` | `payments` | BEFORE UPDATE | Auto-update payment status based on priority |
| `trg_enrollment_grade_update` | `enrollments` | BEFORE UPDATE | Auto-update grade status when grade assigned |

### Payment Status Trigger Logic

The payment triggers use the following priority order:

```
1. PAID      → amount_paid >= amount_due
2. OVERDUE   → due_date < CURDATE() AND amount_paid < amount_due
3. PARTIAL   → amount_paid > 0 AND amount_paid < amount_due
4. UNPAID    → default (no payment made)
```

> ⚠️ **Important:** Overdue is checked BEFORE Partial to ensure past-due partial payments are marked as Overdue, not Partial.

### Grade Status Trigger Logic

```
- Grade ≤ 3.00 → Passed
- Grade = 5.00 → Failed
- Grade = 0.00 → Incomplete
```

---

## Constraints

### CHECK Constraints

| Table | Constraint | Condition |
|-------|------------|-----------|
| `enrollments` | `chk_midterm_grade` | `midterm_grade IS NULL OR midterm_grade BETWEEN 1.00 AND 5.00` |
| `enrollments` | `chk_final_grade` | `final_grade IS NULL OR final_grade BETWEEN 1.00 AND 5.00` |
| `enrollments` | `chk_grade` | `grade IS NULL OR grade BETWEEN 1.00 AND 5.00` |
| `class_schedules` | `chk_schedule_time` | `end_time > start_time` |

### UNIQUE Constraints

| Table | Constraint | Columns |
|-------|------------|---------|
| `departments` | (column) | `department_code` |
| `programs` | (column) | `program_code` |
| `academic_years` | `uk_academic_term` | `academic_year, semester` |
| `curriculum` | `uk_course_program` | `course_code, program_id, effective_year` |
| `instructors` | (column) | `employee_id`, `email` |
| `students` | (column) | `student_number`, `email` |
| `enrollments` | `uk_enrollment` | `student_id, curriculum_id, academic_year_id` |
| `payment_types` | (column) | `type_code` |
| `users` | (column) | `username`, `email` |

---

## Indexes

### Performance Indexes

| Table | Index | Columns | Purpose |
|-------|-------|---------|---------|
| `students` | `idx_student_status` | `student_status` | Filter by status |
| `students` | `idx_student_program` | `current_program_id` | Join with programs |
| `students` | `idx_student_year` | `year_level` | Filter by year |
| `students` | `idx_student_name` | `last_name, first_name` | Name search |
| `enrollments` | `idx_student_year` | `student_id, academic_year_id` | Student semester queries |
| `enrollments` | `idx_enrollment_status` | `enrollment_status` | Filter by status |
| `enrollments` | `idx_enrollment_grade` | `grade_status` | Filter by grade status |
| `enrollments` | `idx_enrollment_instructor` | `instructor_id` | Instructor workload queries |
| `payments` | `idx_payment_status` | `payment_status` | Filter by status |
| `payments` | `idx_payment_date` | `payment_date` | Payment date queries |
| `payments` | `idx_payment_due` | `due_date` | Overdue payment queries |
| `payments` | `idx_payment_student` | `student_id` | Student payments |
| `payments` | `idx_payment_academic` | `academic_year_id` | Term-based queries |
| `payment_types` | `idx_payment_type_category` | `category` | Filter by category |
| `payment_types` | `idx_payment_type_active` | `is_active` | Active types filter |
| `class_schedules` | `idx_schedule_day` | `day_of_week` | Daily schedule |
| `class_schedules` | `idx_schedule_time` | `start_time, end_time` | Time conflicts |

---

## Grade Scale Reference

### Philippine Grading System

| Grade | Equivalent | Description | Grade Point | Status |
|-------|------------|-------------|-------------|--------|
| 1.00 | 1.00 | Excellent | 4.00 | ✅ Passing |
| 1.25 | 1.25 | Very Good | 3.75 | ✅ Passing |
| 1.50 | 1.50 | Very Good | 3.50 | ✅ Passing |
| 1.75 | 1.75 | Good | 3.25 | ✅ Passing |
| 2.00 | 2.00 | Good | 3.00 | ✅ Passing |
| 2.25 | 2.25 | Satisfactory | 2.75 | ✅ Passing |
| 2.50 | 2.50 | Satisfactory | 2.50 | ✅ Passing |
| 2.75 | 2.75 | Fair | 2.25 | ✅ Passing |
| 3.00 | 3.00 | Passing | 2.00 | ✅ Passing |
| 5.00 | 5.00 | Failed | 0.00 | ❌ Failed |

### Academic Standing (Based on Cumulative GPA)

| GPA Range | Standing |
|-----------|----------|
| ≥ 3.50 | Dean's Lister |
| ≥ 3.00 | Honor Student |
| ≥ 2.00 | Good Standing |
| < 2.00 | Needs Improvement |

---

## Sample Queries

### Get Student with Full Profile
```sql
CALL sp_get_student_profile(1);
```

### Get Student Schedule
```sql
CALL sp_get_student_schedule(1);
```

### Calculate Student GPA
```sql
SELECT fn_calculate_cumulative_gpa(1) AS gpa;
```

### Check Prerequisites
```sql
CALL sp_validate_prerequisites(1, 8, @can_enroll, @message);
SELECT @can_enroll, @message;
```

### Set Current Academic Year
```sql
CALL sp_set_current_academic_year(7);
```

### Check Data Integrity
```sql
CALL sp_check_data_integrity();
```

### Get Payment Statistics
```sql
-- All terms
CALL sp_get_payment_stats(NULL);

-- Specific academic year
CALL sp_get_payment_stats(7);
```

### Update Overdue Payments (Run Daily)
```sql
-- Mark past-due unpaid/partial payments as Overdue
CALL sp_update_overdue_payments();
```

### Record New Payment
```sql
CALL sp_record_payment(
    1,              -- student_id
    1,              -- payment_type_id (Tuition)
    7,              -- academic_year_id
    25000.00,       -- amount_due
    25000.00,       -- amount_paid
    CURDATE(),      -- payment_date
    DATE_ADD(CURDATE(), INTERVAL 30 DAY), -- due_date
    'Bank Transfer', -- payment_method
    'REF-2026-001', -- reference_number
    1,              -- processed_by (user_id)
    'Tuition Payment', -- description
    'Full payment'  -- remarks
);
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2025-01-01 | Initial schema |
| 2.0.0 | 2026-01-10 | Renamed PKs to `tablename_id` format |
| 2.1.0 | 2026-01-15 | Renamed `student_pk` → `student_id`, `student_id` → `student_number` |
| 2.2.0 | 2026-01-15 | Added grade_scale, audit_log, GPA functions, CHECK constraints, prerequisite validation |
| 2.3.0 | 2026-01-15 | Fixed payment trigger logic (Overdue priority), added payment procedures, documented all indexes |
| 2.3.0 | 2026-01-15 | Fixed payment trigger logic (Overdue priority), added `sp_record_payment`, `sp_get_payment_stats`, `sp_update_overdue_payments` |

---

*Documentation generated for EMS Database v2.3.0*
