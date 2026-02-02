/**
 * Student Management System - Frontend Optimizations
 * Includes: Debouncing, Form Validation, Lazy Loading, Performance Utils
 */

// ===================================
// Utility Functions
// ===================================

/**
 * Debounce function - delays execution until user stops typing
 * @param {Function} func Function to debounce
 * @param {number} wait Wait time in milliseconds
 * @returns {Function} Debounced function
 */
function debounce(func, wait = 300) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

/**
 * Throttle function - limits execution to once per interval
 * @param {Function} func Function to throttle
 * @param {number} limit Time limit in milliseconds
 * @returns {Function} Throttled function
 */
function throttle(func, limit = 100) {
    let inThrottle;
    return function(...args) {
        if (!inThrottle) {
            func.apply(this, args);
            inThrottle = true;
            setTimeout(() => inThrottle = false, limit);
        }
    };
}

// ===================================
// Form Validation
// ===================================

const Validator = {
    /**
     * Validate email format
     * @param {string} email Email to validate
     * @returns {boolean} True if valid
     */
    isValidEmail(email) {
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return emailRegex.test(email);
    },

    /**
     * Validate phone number (Philippine format)
     * @param {string} phone Phone number to validate
     * @returns {boolean} True if valid
     */
    isValidPhone(phone) {
        if (!phone) return true; // Optional field
        const phoneRegex = /^(09|\+639)\d{9}$/;
        return phoneRegex.test(phone.replace(/[\s-]/g, ''));
    },

    /**
     * Validate required field
     * @param {string} value Value to check
     * @returns {boolean} True if not empty
     */
    isRequired(value) {
        return value !== null && value !== undefined && value.trim() !== '';
    },

    /**
     * Validate date (not in future, reasonable age)
     * @param {string} dateStr Date string to validate
     * @returns {boolean} True if valid
     */
    isValidBirthDate(dateStr) {
        if (!dateStr) return false;
        const date = new Date(dateStr);
        const today = new Date();
        const minDate = new Date();
        minDate.setFullYear(minDate.getFullYear() - 100); // Max 100 years old
        const maxDate = new Date();
        maxDate.setFullYear(maxDate.getFullYear() - 15); // Min 15 years old
        
        return date <= maxDate && date >= minDate;
    },

    /**
     * Show validation error on field
     * @param {HTMLElement} field Input field
     * @param {string} message Error message
     */
    showError(field, message) {
        // Remove existing error
        this.clearError(field);
        
        field.classList.add('input-error');
        const errorDiv = document.createElement('div');
        errorDiv.className = 'validation-error';
        errorDiv.textContent = message;
        field.parentNode.appendChild(errorDiv);
    },

    /**
     * Clear validation error from field
     * @param {HTMLElement} field Input field
     */
    clearError(field) {
        field.classList.remove('input-error');
        const existingError = field.parentNode.querySelector('.validation-error');
        if (existingError) {
            existingError.remove();
        }
    },

    /**
     * Clear all validation errors in a form
     * @param {HTMLFormElement} form Form element
     */
    clearAllErrors(form) {
        form.querySelectorAll('.input-error').forEach(el => el.classList.remove('input-error'));
        form.querySelectorAll('.validation-error').forEach(el => el.remove());
    }
};

// ===================================
// Search with Debouncing
// ===================================

/**
 * Initialize debounced search functionality
 * @param {string} inputSelector Selector for search input
 * @param {number} delay Debounce delay in ms
 */
function initDebouncedSearch(inputSelector = '.search-input', delay = 500) {
    const searchInput = document.querySelector(inputSelector);
    if (!searchInput) return;

    const form = searchInput.closest('form');
    if (!form) return;

    // Create a visual indicator for auto-search
    const indicator = document.createElement('span');
    indicator.className = 'search-indicator';
    indicator.style.cssText = 'display:none;margin-left:8px;color:#6c757d;font-size:12px;';
    searchInput.parentNode.appendChild(indicator);

    const debouncedSearch = debounce(() => {
        indicator.style.display = 'none';
        // Only auto-submit if there's meaningful input (3+ chars) or clearing
        if (searchInput.value.length >= 3 || searchInput.value.length === 0) {
            form.submit();
        }
    }, delay);

    searchInput.addEventListener('input', () => {
        if (searchInput.value.length >= 2) {
            indicator.textContent = 'Searching...';
            indicator.style.display = 'inline';
        }
        debouncedSearch();
    });

    // Prevent double submission on Enter
    searchInput.addEventListener('keydown', (e) => {
        if (e.key === 'Enter') {
            e.preventDefault();
            indicator.style.display = 'none';
            form.submit();
        }
    });
}

// ===================================
// Form Validation Setup
// ===================================

/**
 * Initialize form validation for add/edit student forms
 * @param {string} formSelector Selector for the form
 */
function initFormValidation(formSelector = '.add-student-form, .edit-student-form') {
    const form = document.querySelector(formSelector);
    if (!form) return;

    form.addEventListener('submit', function(e) {
        let isValid = true;
        Validator.clearAllErrors(form);

        // First name validation
        const firstName = form.querySelector('[name="first_name"]');
        if (firstName && !Validator.isRequired(firstName.value)) {
            Validator.showError(firstName, 'First name is required');
            isValid = false;
        }

        // Last name validation
        const lastName = form.querySelector('[name="last_name"]');
        if (lastName && !Validator.isRequired(lastName.value)) {
            Validator.showError(lastName, 'Last name is required');
            isValid = false;
        }

        // Email validation
        const email = form.querySelector('[name="email"]');
        if (email) {
            if (!Validator.isRequired(email.value)) {
                Validator.showError(email, 'Email is required');
                isValid = false;
            } else if (!Validator.isValidEmail(email.value)) {
                Validator.showError(email, 'Please enter a valid email address');
                isValid = false;
            }
        }

        // Date of birth validation
        const dob = form.querySelector('[name="date_of_birth"]');
        if (dob) {
            if (!Validator.isRequired(dob.value)) {
                Validator.showError(dob, 'Date of birth is required');
                isValid = false;
            } else if (!Validator.isValidBirthDate(dob.value)) {
                Validator.showError(dob, 'Please enter a valid date of birth (student must be 15-100 years old)');
                isValid = false;
            }
        }

        // Phone validation (optional but must be valid if provided)
        const phone = form.querySelector('[name="phone"]');
        if (phone && phone.value && !Validator.isValidPhone(phone.value)) {
            Validator.showError(phone, 'Please enter a valid phone number (e.g., 09123456789)');
            isValid = false;
        }

        // Gender validation
        const gender = form.querySelector('[name="gender"]');
        if (gender && !Validator.isRequired(gender.value)) {
            Validator.showError(gender, 'Please select a gender');
            isValid = false;
        }

        // Program validation
        const program = form.querySelector('[name="program_id"]');
        if (program && (!Validator.isRequired(program.value) || program.value === '0')) {
            Validator.showError(program, 'Please select a program');
            isValid = false;
        }

        if (!isValid) {
            e.preventDefault();
            // Scroll to first error
            const firstError = form.querySelector('.input-error');
            if (firstError) {
                firstError.scrollIntoView({ behavior: 'smooth', block: 'center' });
                firstError.focus();
            }
        }
    });

    // Real-time validation on blur
    const fieldsToValidate = ['first_name', 'last_name', 'email', 'phone', 'date_of_birth'];
    fieldsToValidate.forEach(fieldName => {
        const field = form.querySelector(`[name="${fieldName}"]`);
        if (field) {
            field.addEventListener('blur', function() {
                validateField(this);
            });
            field.addEventListener('input', function() {
                if (this.classList.contains('input-error')) {
                    validateField(this);
                }
            });
        }
    });
}

/**
 * Validate a single field
 * @param {HTMLElement} field Input field to validate
 */
function validateField(field) {
    const name = field.name;
    Validator.clearError(field);

    switch(name) {
        case 'first_name':
        case 'last_name':
            if (!Validator.isRequired(field.value)) {
                Validator.showError(field, `${name.replace('_', ' ')} is required`);
            }
            break;
        case 'email':
            if (field.value && !Validator.isValidEmail(field.value)) {
                Validator.showError(field, 'Please enter a valid email address');
            }
            break;
        case 'phone':
            if (field.value && !Validator.isValidPhone(field.value)) {
                Validator.showError(field, 'Please enter a valid phone number');
            }
            break;
        case 'date_of_birth':
            if (field.value && !Validator.isValidBirthDate(field.value)) {
                Validator.showError(field, 'Please enter a valid date of birth');
            }
            break;
    }
}

// ===================================
// Lazy Loading for Tables
// ===================================

/**
 * Initialize lazy loading for table rows (for large datasets)
 * @param {string} tableSelector Selector for the table
 * @param {number} batchSize Number of rows to show initially
 */
function initLazyTable(tableSelector = '.student-table', batchSize = 20) {
    const table = document.querySelector(tableSelector);
    if (!table) return;

    const tbody = table.querySelector('tbody');
    if (!tbody) return;

    const rows = Array.from(tbody.querySelectorAll('tr'));
    if (rows.length <= batchSize) return;

    // Hide rows beyond batchSize
    rows.forEach((row, index) => {
        if (index >= batchSize) {
            row.style.display = 'none';
            row.dataset.lazy = 'true';
        }
    });

    // Add "Load More" button
    const loadMoreBtn = document.createElement('button');
    loadMoreBtn.className = 'btn btn-load-more';
    loadMoreBtn.textContent = `Load More (${rows.length - batchSize} remaining)`;
    loadMoreBtn.style.cssText = 'margin-top:20px;display:block;width:100%;';
    
    table.parentNode.appendChild(loadMoreBtn);

    let currentlyShown = batchSize;

    loadMoreBtn.addEventListener('click', () => {
        const hiddenRows = rows.filter(r => r.dataset.lazy === 'true' && r.style.display === 'none');
        const toShow = hiddenRows.slice(0, batchSize);
        
        toShow.forEach(row => {
            row.style.display = '';
        });

        currentlyShown += toShow.length;
        const remaining = rows.length - currentlyShown;

        if (remaining <= 0) {
            loadMoreBtn.remove();
        } else {
            loadMoreBtn.textContent = `Load More (${remaining} remaining)`;
        }
    });
}

// ===================================
// Performance Monitoring
// ===================================

const Performance = {
    /**
     * Measure and log page load time
     */
    measurePageLoad() {
        window.addEventListener('load', () => {
            setTimeout(() => {
                const timing = performance.timing;
                const loadTime = timing.loadEventEnd - timing.navigationStart;
                console.log(`Page load time: ${loadTime}ms`);
                
                // Store in sessionStorage for debugging
                const loadTimes = JSON.parse(sessionStorage.getItem('pageTimes') || '[]');
                loadTimes.push({
                    url: window.location.pathname,
                    time: loadTime,
                    timestamp: new Date().toISOString()
                });
                // Keep only last 10 measurements
                if (loadTimes.length > 10) loadTimes.shift();
                sessionStorage.setItem('pageTimes', JSON.stringify(loadTimes));
            }, 0);
        });
    },

    /**
     * Log performance metrics to console
     */
    logMetrics() {
        const loadTimes = JSON.parse(sessionStorage.getItem('pageTimes') || '[]');
        console.table(loadTimes);
    }
};

// ===================================
// Toast Notifications
// ===================================

const Toast = {
    /**
     * Show a toast notification
     * @param {string} message Message to display
     * @param {string} type Type: 'success', 'error', 'info'
     * @param {number} duration Duration in ms
     */
    show(message, type = 'info', duration = 5000) {
        // Remove existing toasts
        document.querySelectorAll('.toast-notification').forEach(t => t.remove());

        const toast = document.createElement('div');
        toast.className = `toast-notification toast-${type}`;
        toast.innerHTML = `
            <span class="toast-message">${message}</span>
            <button class="toast-close" onclick="this.parentElement.remove()">&times;</button>
        `;
        document.body.appendChild(toast);

        // Trigger animation
        setTimeout(() => toast.classList.add('toast-show'), 10);

        // Auto-hide
        setTimeout(() => {
            toast.classList.add('toast-hide');
            setTimeout(() => toast.remove(), 300);
        }, duration);
    }
};

// ===================================
// Initialize on DOM Ready
// ===================================

document.addEventListener('DOMContentLoaded', function() {
    // Initialize debounced search
    initDebouncedSearch('.search-input', 500);
    
    // Initialize form validation
    initFormValidation('.add-student-form');
    initFormValidation('.edit-student-form');
    
    // Measure page load performance
    Performance.measurePageLoad();
    
    // Add keyboard shortcuts
    document.addEventListener('keydown', function(e) {
        // Ctrl/Cmd + K for search focus
        if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
            e.preventDefault();
            const searchInput = document.querySelector('.search-input');
            if (searchInput) searchInput.focus();
        }
    });
});

// ===================================
// Drop Student Confirmation
// ===================================

/**
 * Redirect to drop student confirmation page
 * @param {number} id Student ID
 * @param {string} name Student Name
 */
function confirmDrop(id, name) {
    // Redirect to the confirmation page logic (interstitial)
    window.location.href = `pages/drop_student.php?id=${id}`;
}

// Export for use in other scripts
window.StudentApp = {
    Validator,
    Toast,
    Performance,
    debounce,
    throttle
};
