# EMS Pro - Student Information System

A modern, professional Student Information System built with PHP, MySQL, CSS, and JavaScript. Features a desktop application-style interface with comprehensive student management.

## Features

### Core Features
- **Student Management**: Complete student profiling with bio-data capture
- **Class Schedule**: Visual timetable and list view for student class schedules
- **Enrollment History**: Track student enrollments across semesters with grades
- **Payment Tracking**: Full payment history with multiple payment methods
- **Secure Login**: Bcrypt password hashing with session management
- **Desktop UI**: Modern sidebar navigation with collapsible menu

### Student Profile
- Personal Information (Name, DOB, Sex, Civil Status, Nationality)
- Contact Details (Email, Phone)
- Complete Address (Street, Barangay, City, Province, ZIP)
- Guardian/Emergency Contact Information
- Academic Information (Program, Year Level, Section)

### Class Schedule (NEW!)
- **Timetable View**: Visual weekly calendar with color-coded class types
- **List View**: Day-by-day class listing with full details
- **Class Types**: Lecture, Laboratory, Tutorial, Seminar, Online, Hybrid
- **Schedule Stats**: Total hours, lecture/lab breakdown, days per week
- **Today Indicator**: Highlights current day's schedule
- **Room & Instructor Info**: Complete class location and faculty details

### Academic Tracking
- Enrollment history across all semesters
- Subject grades with GWA calculation
- Units tracking (current and total)

### Payment System
- Multiple payment types (Tuition, Lab Fees, Miscellaneous, NSTP, etc.)
- Payment status tracking (Paid, Partial, Unpaid, Overdue)
- Multiple payment methods (Cash, Bank Transfer, GCash, Installment, Scholarship)

## Project Structure

```
Cano-P-EMS/
├── assets/
│   ├── css/
│   │   └── style.css          # Desktop app styling (includes schedule styles)
│   └── js/
│       └── script.js          # Interactive features (schedule toggle)
├── includes/
│   ├── auth.php               # Authentication check
│   ├── db.php                 # Database connection
│   └── functions.php          # Helper functions (CRUD, schedule utilities)
├── pages/
│   └── students.php           # Student management (list, view, add, edit)
├── sql/
│   ├── sis_schema.sql         # Database schema (tables, indexes)
│   ├── sis_sample_data.sql    # Sample data (20 students with history)
│   └── schedules_schema.sql   # Schedule table and sample data (NEW!)
├── templates/
│   ├── header.php             # Page header with authentication
│   └── sidebar.php            # Sidebar navigation
├── favicon.svg                # Application icon
├── index.php                  # Entry point (redirects to students)
├── login.php                  # Login page
├── logout.php                 # Logout handler
└── README.md                  # Documentation
```

## Setup Instructions

### Prerequisites

- **XAMPP** (or similar: WAMP, MAMP, Laragon)
- **Web Browser** (Chrome, Firefox, Edge)
- PHP 7.4+ with PDO extension
- MySQL 5.7+

### Step-by-Step Setup

1. **Copy project folder**
   
   Copy to your web server's document root:
   - XAMPP: `C:\xampp\htdocs\Cano-P-EMS\`

2. **Start your local server**
   
   Open XAMPP Control Panel and start:
   - Apache
   - MySQL

3. **Create the database**
   
   Option A - Using Command Line:
   ```bash
   mysql -u root -e "CREATE DATABASE IF NOT EXISTS ems_O6"
   mysql -u root ems_O6 < sql/sis_schema.sql
   mysql -u root ems_O6 < sql/sis_sample_data.sql
   mysql -u root ems_O6 < sql/schedules_schema.sql
   ```
   
   Option B - Using phpMyAdmin:
   - Open http://localhost/phpmyadmin
   - Create database: `ems_O6`
   - Import `sql/sis_schema.sql` first
   - Import `sql/sis_sample_data.sql` second
   - Import `sql/schedules_schema.sql` third (for schedule feature)

4. **Configure database connection** (if needed)
   
   Edit `includes/db.php`:
   ```php
   define('DB_HOST', 'localhost');
   define('DB_USERNAME', 'root');
   define('DB_PASSWORD', '');
   define('DB_NAME', 'ems_O6');
   ```

5. **Open in browser**
   
   Visit: http://localhost/Cano-P-EMS/

### Default Login Credentials

| Username | Password | Role |
|----------|----------|------|
| admin    | admin123 | Admin |
| staff    | staff123 | Staff |

## How to Use

### Managing Students
1. Login with your credentials
2. View the student list with search and filters
3. Click a student row to view their complete profile
4. Use tabs to switch between Overview, Subjects, and Payments
5. Use "Add Student" to create new records

### Viewing Enrollment History
1. Open a student's profile
2. Click the "Subjects" tab
3. Use the dropdown to select a specific semester or "Show All"
4. View grades, units, and GWA for each term

### Viewing Payment History
1. Open a student's profile
2. Click the "Payments" tab
3. Use the dropdown to select a specific term or "Show All"
4. View payment details, amounts, and status

## Database Schema

### Main Tables
- `students` - Student personal and academic information
- `programs` - Available degree programs
- `subjects` - Course catalog with units
- `enrollments` - Student-subject enrollments with grades
- `payments` - Payment records with status
- `payment_types` - Fee categories
- `users` - System users with roles

## Customization

### Changing Colors
Edit `assets/css/style.css`:
```css
:root {
    --primary-color: #0078d4;
    --success-color: #059669;
    --danger-color: #dc2626;
}
```

### Adding New Programs
Insert into `programs` table via phpMyAdmin or SQL.

## Troubleshooting

**"Couldn't connect to database" error**
- Ensure MySQL is running in XAMPP
- Verify database `ems_O6` exists
- Check credentials in `includes/db.php`

**Login not working**
- Re-import `sis_sample_data.sql` to reset users
- Clear browser cookies/cache

**Styles not loading**
- Access via localhost, not file://
- Clear browser cache (Ctrl+Shift+R)

## Technologies Used

- **PHP 7.4+**: Backend logic with PDO
- **MySQL**: Relational database
- **CSS3**: Modern styling with CSS variables
- **JavaScript**: Interactive features
- **Font Awesome 6**: Icon library
- **bcrypt**: Secure password hashing

## License

Free to use for learning and personal projects.

---

**EMS Pro** - Student Information System
