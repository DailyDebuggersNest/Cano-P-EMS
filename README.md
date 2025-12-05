# Enrollment Management System (EMS)

A simple, beginner-friendly Enrollment Management System built with PHP, MySQL, CSS, and JavaScript.

## Features

- **Student Management**: Add, view, edit, and delete students
- **Course Management**: Add, view, edit, and delete courses  
- **Enrollment System**: Enroll students in courses (many-to-many relationship)
- **Dashboard**: Quick overview with stats and recent activity
- **Clean UI**: Modern, responsive design that works on all devices
- **Font Awesome Icons**: Professional iconography throughout the interface

## Project Structure

```
EMS-starter/
├── assets/
│   ├── css/
│   │   └── style.css       # All the styling
│   └── js/
│       └── script.js       # JavaScript for interactions
├── includes/
│   ├── db.php              # Database connection
│   └── functions.php       # Helper functions (CRUD operations)
├── templates/
│   ├── header.php          # HTML head section
│   ├── navbar.php          # Navigation bar
│   └── footer.php          # Page footer
├── pages/
│   ├── students.php        # Student management page
│   ├── courses.php         # Course management page
│   └── enrollments.php     # Enrollment management page
├── sql/
│   └── database.sql        # Database schema + sample data
├── index.php               # Dashboard/home page
└── README.md               # You're reading it!
```

## Setup Instructions

### Prerequisites

- **XAMPP** (or similar: WAMP, MAMP, Laragon)
- **Web Browser** (Chrome, Firefox, Edge, etc.)

### Step-by-Step Setup

1. **Copy the project folder**
   
   Copy the `EMS-starter` folder to your web server's document root:
   - XAMPP: `C:\xampp\htdocs\`
   - WAMP: `C:\wamp64\www\`
   - MAMP: `/Applications/MAMP/htdocs/`

2. **Start your local server**
   
   Open XAMPP Control Panel and start:
   - Apache
   - MySQL

3. **Create the database**
   
   - Open phpMyAdmin: http://localhost/phpmyadmin
   - Click "Import" tab
   - Choose the file: `sql/database.sql`
   - Click "Go" to import
   
   Or manually:
   - Create a new database called `ems_database`
   - Run the SQL commands from `sql/database.sql`

4. **Configure database connection** (if needed)
   
   Open `includes/db.php` and update these if your setup is different:
   ```php
   define('DB_HOST', 'localhost');
   define('DB_USERNAME', 'root');
   define('DB_PASSWORD', '');  // Default XAMPP has no password
   define('DB_NAME', 'ems_database');
   ```

5. **Open in browser**
   
   Visit: http://localhost/EMS-starter/

## How to Use

### Managing Students
1. Click "Students" in the navigation
2. Click "Add Student" to create a new student
3. Use "Edit" to modify or "Delete" to remove

### Managing Courses
1. Click "Courses" in the navigation
2. Click "Add Course" to create a new course
3. Use "Edit" to modify or "Delete" to remove

### Creating Enrollments
1. Click "Enrollments" in the navigation
2. Click "New Enrollment"
3. Select a student and a course
4. Click "Enroll Student"

## Customization

### Changing Colors
Edit `assets/css/style.css` and modify the CSS variables at the top:
```css
:root {
    --primary-color: #4f46e5;    /* Change this for a different theme */
    --success-color: #10b981;
    --danger-color: #ef4444;
    /* ... etc */
}
```

### Adding New Fields
1. Update the database table in phpMyAdmin
2. Add the field to the form in the respective page
3. Update the functions in `includes/functions.php`

## Troubleshooting

**"Couldn't connect to database" error**
- Make sure MySQL is running in XAMPP
- Check that the database `ems_database` exists
- Verify credentials in `includes/db.php`

**Blank page / PHP errors**
- Enable PHP error display in `php.ini` for debugging
- Check Apache error logs in XAMPP

**Styles not loading**
- Make sure you're accessing via localhost, not file://
- Clear browser cache

## Learning Resources

This project is perfect for learning:
- **PHP basics**: Variables, functions, forms, sessions
- **MySQL**: CRUD operations, JOINs, relationships
- **PDO**: Secure database queries with prepared statements
- **CSS**: Modern layouts with Flexbox and Grid
- **JavaScript**: Form validation, DOM manipulation

## Contributing

This is a learning project! Feel free to:
- Add new features
- Improve the code
- Fix bugs
- Share with others

## License

Free to use for learning and personal projects.

---

Built for learning PHP
