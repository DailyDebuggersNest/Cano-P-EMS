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
    overlay.style.cssText = 'position:fixed;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.4);display:flex;align-items:center;justify-content:center;z-index:1000;';
    
    // Create dialog
    const dialog = document.createElement('div');
    dialog.className = 'dialog';
    dialog.style.cssText = 'background:#ffffff;border:1px solid #e5e7eb;border-radius:12px;min-width:400px;max-width:90%;box-shadow:0 20px 25px -5px rgba(0,0,0,0.1),0 8px 10px -6px rgba(0,0,0,0.1);';
    
    dialog.innerHTML = `
        <div style="padding:16px 20px;border-bottom:1px solid #e5e7eb;display:flex;justify-content:space-between;align-items:center;">
            <h3 style="font-size:16px;font-weight:600;color:#111827;display:flex;align-items:center;gap:10px;">
                <i class="fas fa-exclamation-triangle" style="color:#dc2626;"></i>
                Confirm Delete
            </h3>
            <button onclick="this.closest('.dialog-overlay').remove()" style="background:none;border:none;color:#6b7280;cursor:pointer;font-size:18px;padding:4px;">
                <i class="fas fa-times"></i>
            </button>
        </div>
        <div style="padding:24px 20px;">
            <p style="color:#374151;font-size:14px;margin-bottom:12px;">
                Are you sure you want to delete this ${itemType}?
            </p>
            <p style="color:#111827;font-size:13px;background:#f3f4f6;padding:10px 14px;border-radius:8px;margin:16px 0;border:1px solid #e5e7eb;">
                "${itemName}"
            </p>
            <p style="color:#dc2626;font-size:12px;display:flex;align-items:center;gap:6px;">
                <i class="fas fa-info-circle"></i> This action cannot be undone.
            </p>
        </div>
        <div style="padding:16px 20px;border-top:1px solid #e5e7eb;display:flex;justify-content:flex-end;gap:10px;background:#f9fafb;">
            <button onclick="this.closest('.dialog-overlay').remove()" 
                    style="padding:8px 16px;font-size:13px;font-weight:500;background:#ffffff;color:#374151;border:1px solid #d1d5db;border-radius:8px;cursor:pointer;">
                Cancel
            </button>
            <button onclick="window.location.href='${deleteUrl}'" 
                    style="padding:8px 16px;font-size:13px;font-weight:500;background:#dc2626;color:white;border:none;border-radius:8px;cursor:pointer;">
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
});

// ============================================
// COLLAPSIBLE SEMESTER BLOCKS
// Toggle academic history semester details
// ============================================

/**
 * Show selected semester from dropdown
 * Hides all semester content and shows only the selected one
 * If 'all' is selected, shows all semesters
 */
function showSelectedSemester() {
    const selector = document.getElementById('semesterSelector');
    if (!selector) return;
    
    const selectedValue = selector.value;
    const allSemesters = document.querySelectorAll('.semester-content');
    
    if (selectedValue === 'all') {
        // Show all semesters
        allSemesters.forEach(function(sem) {
            sem.style.display = 'block';
        });
    } else {
        // Hide all semester contents
        allSemesters.forEach(function(sem) {
            sem.style.display = 'none';
        });
        
        // Show the selected semester
        const selectedSemester = document.getElementById('semester-' + selectedValue);
        if (selectedSemester) {
            selectedSemester.style.display = 'block';
        }
    }
}

/**
 * Show selected payment semester from dropdown
 * Hides all payment content and shows only the selected one
 * If 'all' is selected, shows all payment terms
 */
function showSelectedPaymentSemester() {
    const selector = document.getElementById('paymentSemesterSelector');
    if (!selector) return;
    
    const selectedValue = selector.value;
    const allPayments = document.querySelectorAll('.payment-content');
    
    if (selectedValue === 'all') {
        // Show all payment terms
        allPayments.forEach(function(payment) {
            payment.style.display = 'block';
        });
    } else {
        // Hide all payment contents
        allPayments.forEach(function(payment) {
            payment.style.display = 'none';
        });
        
        // Show the selected payment term
        const selectedPayment = document.getElementById('payment-semester-' + selectedValue);
        if (selectedPayment) {
            selectedPayment.style.display = 'block';
        }
    }
}
