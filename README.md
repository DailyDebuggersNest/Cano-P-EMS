# 📚 EMS - Enrollment Management System

A comprehensive Enrollment Management System built with PHP, MySQL, and modern web technologies. Features a desktop application-style interface for managing student enrollment, academic records, payments, and scheduling.

**Version:** 2.3.0  
**Database:** MySQL 8.0+ / MariaDB 10.5+

---

## ✨ Features

### 🎓 Student Management
- Complete student profiling with personal, contact, and guardian information
- Academic tracking (program, year level, section, status)
- Student search with filters (program, year level, status)
- Profile photo support

### 📅 Class Scheduling
- Visual timetable view with color-coded class types
- Day-by-day list view with full details
- Support for Lecture, Laboratory, Tutorial, Seminar, Online, Hybrid classes
- Room and building assignments
- Schedule conflict detection

### 📖 Enrollment Tracking
- Subject enrollment per academic term
- Midterm, Final, and computed grades
- Grade status tracking (Pending, Passed, Failed, Incomplete)
- Prerequisite validation before enrollment
- GPA calculation (semester and cumulative)

### 💰 Payment System
- Multiple payment types (Tuition, Laboratory, Miscellaneous, Other)
- Payment status auto-calculation via triggers:
  - **Paid** → Full payment received
  - **Overdue** → Past due date with balance
  - **Partial** → Partial payment made
  - **Unpaid** → No payment made
- Multiple payment methods (Cash, Bank Transfer, Online, Check, etc.)
- Payment history per student and academic term

### 👥 User Management
- Role-based access (Super Admin, Admin, Registrar, Faculty, Staff, Student)
- Secure login with bcrypt password hashing
- Session management with remember me option
- Account lockout after failed attempts

### 🏫 Academic Management
- Department and college organization
- Program/course management with accreditation status
- Curriculum management with prerequisites
- Academic year and semester tracking
- Instructor/faculty records

---

## 📊 Database Overview

| Component | Count |
|-----------|-------|
| Tables | 14 |
| Views | 12 |
| Stored Procedures | 20 |
| Functions | 2 |
| Triggers | 3 |

For complete database documentation, see [docs/DB_DESIGN.md](docs/DB_DESIGN.md)

---

## 📁 Project Structure

```
Cano-P-EMS/
├── assets/
│   ├── css/
│   │   └── style.css           # Application styling
│   └── js/
│       └── script.js           # Interactive features
├── docs/
│   └── DB_DESIGN.md            # Database documentation & ERD
├── includes/
│   ├── auth.php                # Authentication middleware
│   ├── db.php                  # Database connection (PDO)
│   └── functions.php           # Helper functions
├── pages/
│   └── students.php            # Student management page
├── sql/
│   ├── schema.sql              # Complete database schema (v2.3.0)
│   └── sample_data.sql         # Sample data for testing
├── templates/
│   ├── header.php              # Page header
│   └── sidebar.php             # Navigation sidebar
├── favicon.svg                 # Application icon
├── index.php                   # Entry point
├── login.php                   # Login page
├── logout.php                  # Logout handler
├── test_db.php                 # Database connection test
└── README.md                   # This file
```

---

## 🚀 Installation

### Prerequisites

- **XAMPP** (Apache + MySQL + PHP) or similar stack
- **PHP 7.4+** with PDO extension
- **MySQL 8.0+** or **MariaDB 10.5+**
- Modern web browser

### Setup Steps

1. **Clone or copy the project**
   ```bash
   cd C:\xampp\htdocs
   git clone https://github.com/DailyDebuggersNest/Cano-P-EMS.git
   ```

2. **Start XAMPP services**
   - Open XAMPP Control Panel
   - Start **Apache** and **MySQL**

3. **Create and import database**

   **Option A - phpMyAdmin:**
   - Open http://localhost/phpmyadmin
   - Create database: `ems_O6`
   - Import `sql/schema.sql`
   - Import `sql/sample_data.sql`

   **Option B - Command Line:**
   ```bash
   mysql -u root -e "CREATE DATABASE IF NOT EXISTS ems_O6"
   mysql -u root ems_O6 < sql/schema.sql
   mysql -u root ems_O6 < sql/sample_data.sql
   ```

4. **Configure database connection** (if needed)
   
   Edit `includes/db.php`:
   ```php
   define('DB_HOST', 'localhost');
   define('DB_USERNAME', 'root');
   define('DB_PASSWORD', '');
   define('DB_NAME', 'ems_O6');
   ```

5. **Access the application**
   
   Open: http://localhost/Cano-P-EMS/

---

## 🔐 Default Login Credentials

| Username | Password | Role |
|----------|----------|------|
| admin | admin123 | Admin |
| staff | staff123 | Staff |

---

## 💡 Usage

### View Students
1. Login with credentials
2. Browse student list with search/filters
3. Click a student to view profile

### View Student Schedule
```sql
-- In phpMyAdmin, run:
CALL sp_get_student_schedule(1);  -- Replace 1 with student_id

-- Or view all schedules:
SELECT * FROM vw_class_schedule;
```

### Calculate GPA
```sql
SELECT fn_calculate_gpa(1, 7) AS semester_gpa;           -- Student 1, Academic Year 7
SELECT fn_calculate_cumulative_gpa(1) AS cumulative_gpa; -- Student 1, all terms
```

### Check Payment Status
```sql
CALL sp_get_payment_stats(NULL);  -- All terms
CALL sp_get_payment_stats(7);     -- Specific academic year
```

### Update Overdue Payments (run daily)
```sql
CALL sp_update_overdue_payments();
```

---

## 🛠️ Troubleshooting

| Issue | Solution |
|-------|----------|
| Database connection error | Ensure MySQL is running; check `includes/db.php` credentials |
| Login not working | Re-import `sample_data.sql` to reset users |
| Styles not loading | Access via `localhost`, not `file://`; clear browser cache |
| Missing tables/views | Re-import `schema.sql` (includes all objects) |

---

## 🔧 Technologies

| Technology | Purpose |
|------------|---------|
| PHP 7.4+ | Backend logic with PDO |
| MySQL/MariaDB | Relational database |
| HTML5/CSS3 | Frontend structure and styling |
| JavaScript | Interactive features |
| Font Awesome 6 | Icons |
| bcrypt | Password hashing |

---

## 📝 Version History

| Version | Date | Changes |
|---------|------|---------|
| 2.3.0 | 2026-01-15 | Fixed payment triggers, added payment procedures, grade_scale table |
| 2.2.0 | 2026-01-14 | Added 4 views, 6 procedures for reporting |
| 2.1.0 | 2026-01-13 | UI improvements, schedule features |
| 2.0.0 | 2026-01-12 | Initial release with core features |

---

## 📄 License

Free to use for educational and personal projects.

---

**EMS** - Enrollment Management System  
Developed for academic project demonstration
