/**
 * EMS JavaScript - Desktop Application Style
 * 
 * Handles interactive features for the desktop-style interface
 */

// ============================================
// SIDEBAR TOGGLE
// Expand/collapse sidebar with hamburger button
// ============================================

document.addEventListener('DOMContentLoaded', function() {
    const sidebar = document.getElementById('sidebar');
    const toggleBtn = document.getElementById('sidebarToggle');
    
    if (sidebar && toggleBtn) {
        // Load saved state from localStorage
        const isExpanded = localStorage.getItem('sidebarExpanded') === 'true';
        if (isExpanded) {
            sidebar.classList.add('expanded');
        }
        
        // Toggle sidebar on button click
        toggleBtn.addEventListener('click', function() {
            sidebar.classList.toggle('expanded');
            // Save state to localStorage
            localStorage.setItem('sidebarExpanded', sidebar.classList.contains('expanded'));
        });
    }
    
    // Profile dropdown toggle
    const profileAvatar = document.getElementById('profileAvatar');
    const profileDropdown = document.getElementById('profileDropdown');
    
    if (profileAvatar && profileDropdown) {
        profileAvatar.addEventListener('click', function(e) {
            e.stopPropagation();
            profileDropdown.classList.toggle('show');
        });
        
        // Close dropdown when clicking outside
        document.addEventListener('click', function(e) {
            if (!profileDropdown.contains(e.target) && e.target !== profileAvatar) {
                profileDropdown.classList.remove('show');
            }
        });
    }
});

// ============================================
// MOBILE SIDEBAR MENU
// Toggle sidebar on smaller screens
// ============================================

function toggleMobileMenu() {
    const sidebar = document.querySelector('.sidebar');
    const overlay = document.querySelector('.mobile-overlay');
    
    if (sidebar) {
        sidebar.classList.toggle('show');
    }
    
    if (overlay) {
        overlay.classList.toggle('show');
    }
}

// Close sidebar when clicking overlay
document.addEventListener('click', function(event) {
    const sidebar = document.querySelector('.sidebar');
    const mobileBtn = document.querySelector('.mobile-menu-btn');
    const overlay = document.querySelector('.mobile-overlay');
    
    if (overlay && event.target === overlay) {
        sidebar.classList.remove('show');
        overlay.classList.remove('show');
    }
});

// ============================================
// FORM VALIDATION
// Make sure users fill out forms correctly
// ============================================

/**
 * Validate an email address
 * @param {string} email - The email to check
 * @returns {boolean} - Is it a valid email format?
 */
function isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
}

/**
 * Show a validation error on a form field
 * @param {HTMLElement} input - The input element
 * @param {string} message - Error message to show
 */
function showError(input, message) {
    // Remove any existing error
    clearError(input);
    
    // Add error styling
    input.classList.add('error');
    input.style.borderColor = '#f44336';
    
    // Create and add error message
    const errorDiv = document.createElement('div');
    errorDiv.className = 'error-message';
    errorDiv.textContent = message;
    errorDiv.style.color = '#f44336';
    errorDiv.style.fontSize = '11px';
    errorDiv.style.marginTop = '4px';
    
    input.parentNode.appendChild(errorDiv);
}

/**
 * Clear validation error from a form field
 * @param {HTMLElement} input - The input element
 */
function clearError(input) {
    input.classList.remove('error');
    const errorMsg = input.parentNode.querySelector('.error-message');
    if (errorMsg) {
        errorMsg.remove();
    }
}

/**
 * Validate the student form
 * @param {HTMLFormElement} form - The form element
 * @returns {boolean} - Is the form valid?
 */
function validateStudentForm(form) {
    let isValid = true;
    
    // Check first name
    const firstName = form.querySelector('[name="first_name"]');
    if (!firstName.value.trim()) {
        showError(firstName, 'First name is required');
        isValid = false;
    } else {
        clearError(firstName);
    }
    
    // Check last name
    const lastName = form.querySelector('[name="last_name"]');
    if (!lastName.value.trim()) {
        showError(lastName, 'Last name is required');
        isValid = false;
    } else {
        clearError(lastName);
    }
    
    // Check email
    const email = form.querySelector('[name="email"]');
    if (!email.value.trim()) {
        showError(email, 'Email is required');
        isValid = false;
    } else if (!isValidEmail(email.value)) {
        showError(email, 'Please enter a valid email address');
        isValid = false;
    } else {
        clearError(email);
    }
    
    return isValid;
}

/**
 * Validate the course form
 * @param {HTMLFormElement} form - The form element
 * @returns {boolean} - Is the form valid?
 */
function validateCourseForm(form) {
    let isValid = true;
    
    // Check course code
    const courseCode = form.querySelector('[name="course_code"]');
    if (!courseCode.value.trim()) {
        showError(courseCode, 'Course code is required');
        isValid = false;
    } else {
        clearError(courseCode);
    }
    
    // Check course name
    const courseName = form.querySelector('[name="course_name"]');
    if (!courseName.value.trim()) {
        showError(courseName, 'Course name is required');
        isValid = false;
    } else {
        clearError(courseName);
    }
    
    // Check credits (if provided)
    const credits = form.querySelector('[name="credits"]');
    if (credits && credits.value) {
        const creditValue = parseInt(credits.value);
        if (isNaN(creditValue) || creditValue < 1 || creditValue > 10) {
            showError(credits, 'Credits must be between 1 and 10');
            isValid = false;
        } else {
            clearError(credits);
        }
    }
    
    return isValid;
}

// ============================================
// DELETE CONFIRMATION
// Desktop-style confirmation dialog
// ============================================

/**
 * Show a confirmation dialog before deleting
 * @param {string} itemType - What are we deleting? (student, course, enrollment)
 * @param {string} itemName - The name/identifier of the item
 * @param {string} deleteUrl - Where to go if they confirm
 */
function confirmDelete(itemType, itemName, deleteUrl) {
    // Create overlay
    const overlay = document.createElement('div');
    overlay.className = 'dialog-overlay';
    overlay.style.cssText = 'position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.6);display:flex;align-items:center;justify-content:center;z-index:1000;';
    
    // Create dialog
    const dialog = document.createElement('div');
    dialog.className = 'dialog';
    dialog.style.cssText = 'background:#2d2d2d;border:1px solid #3c3c3c;border-radius:4px;min-width:380px;max-width:90%;box-shadow:0 8px 32px rgba(0,0,0,0.3);';
    
    dialog.innerHTML = `
        <div style="padding:12px 16px;border-bottom:1px solid #3c3c3c;display:flex;justify-content:space-between;align-items:center;">
            <h3 style="font-size:14px;font-weight:600;color:#e0e0e0;display:flex;align-items:center;gap:8px;">
                <i class="fas fa-exclamation-triangle" style="color:#f44336;"></i>
                Confirm Delete
            </h3>
            <button onclick="this.closest('.dialog-overlay').remove()" style="background:none;border:none;color:#9d9d9d;cursor:pointer;font-size:16px;">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <div style="padding:20px 16px;">
            <p style="color:#e0e0e0;font-size:13px;margin-bottom:8px;">
                Are you sure you want to delete this ${itemType}?
            </p>
            <p style="color:#9d9d9d;font-size:12px;background:#3c3c3c;padding:8px 12px;border-radius:2px;margin:12px 0;">
                "${itemName}"
            </p>
            <p style="color:#f44336;font-size:11px;">
                <i class="fas fa-info-circle"></i> This action cannot be undone.
            </p>
        </div>
        <div style="padding:12px 16px;border-top:1px solid #3c3c3c;display:flex;justify-content:flex-end;gap:8px;">
            <button onclick="this.closest('.dialog-overlay').remove()" 
                    style="padding:6px 12px;font-size:12px;font-weight:500;background:#3c3c3c;color:#e0e0e0;border:1px solid #5c5c5c;border-radius:2px;cursor:pointer;">
                Cancel
            </button>
            <button onclick="window.location.href='${deleteUrl}'" 
                    style="padding:6px 12px;font-size:12px;font-weight:500;background:#f44336;color:white;border:1px solid #f44336;border-radius:2px;cursor:pointer;">
                <i class="fas fa-trash"></i> Delete
            </button>
        </div>
    `;
    
    overlay.appendChild(dialog);
    document.body.appendChild(overlay);
    
    // Close on escape key
    document.addEventListener('keydown', function closeOnEsc(e) {
        if (e.key === 'Escape') {
            overlay.remove();
            document.removeEventListener('keydown', closeOnEsc);
        }
    });
    
    // Close on overlay click
    overlay.addEventListener('click', function(e) {
        if (e.target === overlay) {
            overlay.remove();
        }
    });
}

// ============================================
// AUTO-DISMISS ALERTS
// Flash messages disappear after a few seconds
// ============================================

document.addEventListener('DOMContentLoaded', function() {
    // Find all alerts
    const alerts = document.querySelectorAll('.alert');
    
    alerts.forEach(function(alert) {
        // Auto-dismiss after 4 seconds
        setTimeout(function() {
            alert.style.opacity = '0';
            alert.style.transform = 'translateY(-10px)';
            
            // Remove from DOM after fade out
            setTimeout(function() {
                alert.remove();
            }, 200);
        }, 4000);
    });
});

// ============================================
// FORM ENHANCEMENTS
// Little touches to make forms nicer
// ============================================

document.addEventListener('DOMContentLoaded', function() {
    // Clear validation errors when user starts typing
    const inputs = document.querySelectorAll('.form-control');
    
    inputs.forEach(function(input) {
        input.addEventListener('input', function() {
            clearError(this);
        });
    });
    
    // Add form validation to student forms
    const studentForms = document.querySelectorAll('form[data-validate="student"]');
    studentForms.forEach(function(form) {
        form.addEventListener('submit', function(e) {
            if (!validateStudentForm(form)) {
                e.preventDefault();
            }
        });
    });
    
    // Add form validation to course forms
    const courseForms = document.querySelectorAll('form[data-validate="course"]');
    courseForms.forEach(function(form) {
        form.addEventListener('submit', function(e) {
            if (!validateCourseForm(form)) {
                e.preventDefault();
            }
        });
    });
});

// ============================================
// UTILITY FUNCTIONS
// Handy helpers
// ============================================

/**
 * Format a date nicely
 * @param {string} dateString - Date in YYYY-MM-DD format
 * @returns {string} - Formatted date
 */
function formatDate(dateString) {
    if (!dateString) return 'N/A';
    
    const options = { year: 'numeric', month: 'short', day: 'numeric' };
    return new Date(dateString).toLocaleDateString('en-US', options);
}

/**
 * Capitalize the first letter of a string
 * @param {string} str - The string to capitalize
 * @returns {string} - Capitalized string
 */
function capitalize(str) {
    return str.charAt(0).toUpperCase() + str.slice(1);
}

// ============================================
// That's it! Pretty simple, right? 
// Feel free to add more features as you learn!
// ============================================
