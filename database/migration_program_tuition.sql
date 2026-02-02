-- =============================================================================
-- Migration: Add Program-Specific Tuition Rates & Overpayment Tracking
-- Database: school_db21
-- Version: 1.1
-- Date: 2026-01-31
-- 
-- This migration adds:
-- 1. program_tuition_rates table - Program-specific tuition and lab fees
-- 2. term_overpayments table - Track overpayments for carry-forward
-- =============================================================================

USE school_db21;

-- -----------------------------------------------------------------------------
-- Table: program_tuition_rates
-- Stores program-specific tuition rates (BSCS/BSIT higher than BSE, etc.)
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS program_tuition_rates (
    rate_id INT PRIMARY KEY AUTO_INCREMENT,
    program_id INT NOT NULL,
    tuition_per_unit DECIMAL(10,2) NOT NULL DEFAULT 800.00,
    lab_fee DECIMAL(10,2) NOT NULL DEFAULT 2000.00,
    effective_date DATE NOT NULL DEFAULT '2025-01-01',
    is_active BOOLEAN DEFAULT TRUE,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (program_id) REFERENCES programs(program_id) ON DELETE CASCADE,
    UNIQUE KEY unique_program_rate (program_id, effective_date),
    INDEX idx_program_active (program_id, is_active)
);

-- -----------------------------------------------------------------------------
-- Table: term_overpayments
-- Tracks overpayments to carry forward to next term
-- -----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS term_overpayments (
    overpayment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    source_academic_year VARCHAR(20) NOT NULL,
    source_semester INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    applied_academic_year VARCHAR(20) DEFAULT NULL,
    applied_semester INT DEFAULT NULL,
    is_applied BOOLEAN DEFAULT FALSE,
    applied_date TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    INDEX idx_student_overpayment (student_id, is_applied),
    INDEX idx_source_term (student_id, source_academic_year, source_semester)
);

-- -----------------------------------------------------------------------------
-- Insert Program-Specific Tuition Rates
-- BSIT (1): ₱1,200/unit - Higher rate for tech equipment
-- BSCS (2): ₱1,350/unit - Highest rate - advanced computing resources
-- BSIS (3): ₱1,100/unit - Moderate tech rate
-- BSBA (4): ₱900/unit - Standard business rate
-- BSE (5): ₱750/unit - Lower rate for education program
-- -----------------------------------------------------------------------------
INSERT INTO program_tuition_rates (program_id, tuition_per_unit, lab_fee, effective_date, is_active, notes) VALUES
(1, 1200.00, 3500.00, '2025-01-01', TRUE, 'BSIT - Information Technology (Higher rate for tech equipment)'),
(2, 1350.00, 4000.00, '2025-01-01', TRUE, 'BSCS - Computer Science (Highest rate - advanced computing resources)'),
(3, 1100.00, 2500.00, '2025-01-01', TRUE, 'BSIS - Information Systems (Moderate tech rate)'),
(4, 900.00, 1500.00, '2025-01-01', TRUE, 'BSBA - Business Administration (Standard business rate)'),
(5, 750.00, 1000.00, '2025-01-01', TRUE, 'BSE - Education (Lower rate for education program)')
ON DUPLICATE KEY UPDATE 
    tuition_per_unit = VALUES(tuition_per_unit),
    lab_fee = VALUES(lab_fee),
    notes = VALUES(notes);

-- Update the TUITION fee description to clarify it's the base rate
UPDATE fees SET description = 'Tuition Fee (per unit) - Base Rate' WHERE code = 'TUITION';

-- =============================================================================
-- Summary of Tuition Rates:
-- =============================================================================
-- | Program | Rate/Unit | Lab Fee | Total per 24 units (typical semester) |
-- |---------|-----------|---------|----------------------------------------|
-- | BSCS    | ₱1,350    | ₱4,000  | ₱36,400 + misc fees                    |
-- | BSIT    | ₱1,200    | ₱3,500  | ₱32,300 + misc fees                    |
-- | BSIS    | ₱1,100    | ₱2,500  | ₱28,900 + misc fees                    |
-- | BSBA    | ₱900      | ₱1,500  | ₱23,100 + misc fees                    |
-- | BSE     | ₱750      | ₱1,000  | ₱19,000 + misc fees                    |
-- =============================================================================

SELECT 'Migration completed successfully!' AS status;
