<?php
/**
 * Analytics Dashboard
 * Comprehensive reporting and analytics for the student management system
 */
require_once '../config/db_helpers.php';

$conn = getDBConnection();

// Get system settings
$settings = [];
$set_res = db_query($conn, "SELECT setting_key, setting_value FROM system_settings");
while ($row = $set_res->fetch_assoc()) {
    $settings[$row['setting_key']] = $row['setting_value'];
}
$current_ay = $settings['current_academic_year'] ?? (date('Y') . '-' . (date('Y') + 1));

// Get available academic years
$ay_sql = "SELECT DISTINCT academic_year FROM enrollments ORDER BY academic_year DESC";
$academic_years = db_fetch_all(db_query($conn, $ay_sql));

$conn->close();
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics Dashboard - Student Management System</title>
    <link rel="stylesheet" href="../css/common.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* Dashboard-specific overrides - Enhanced UI/UX */
        body {
            background: var(--bg);
            color: var(--text);
        }
        
        /* Header - Clean gradient with depth */
        .dashboard-header {
            background: linear-gradient(135deg, var(--primary) 0%, #5b4dd4 100%);
            color: white;
            padding: 24px 32px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            border-radius: var(--radius-lg);
            margin-bottom: 28px;
            box-shadow: 0 4px 20px rgba(67, 56, 202, 0.25);
        }
        
        .dashboard-header h1 {
            margin: 0;
            font-size: 1.6rem;
            color: white;
            font-weight: 600;
            letter-spacing: -0.02em;
        }
        
        .header-controls {
            display: flex;
            gap: 12px;
            align-items: center;
        }
        
        .header-controls label {
            color: rgba(255,255,255,0.8);
            font-size: 0.875rem;
        }
        
        .header-controls select, .header-controls input {
            padding: 10px 14px;
            border: none;
            border-radius: var(--radius-md);
            background: rgba(255,255,255,0.95);
            font-size: 0.875rem;
            font-weight: 500;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            cursor: pointer;
            transition: all 0.2s;
        }
        
        .header-controls select:hover, .header-controls input:hover {
            background: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .header-controls .btn {
            background: white;
            color: var(--primary);
            border: none;
            padding: 10px 18px;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .header-controls .btn:hover {
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .dashboard-container {
            max-width: 1440px;
            margin: 0 auto;
            padding: 0;
        }
        
        /* Stats Cards - Enhanced with icons and better visual hierarchy */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 16px;
            margin-bottom: 28px;
        }
        
        .stat-card {
            background: var(--surface);
            border-radius: var(--radius-lg);
            padding: 20px 18px;
            border: 1px solid var(--border);
            position: relative;
            overflow: hidden;
            transition: all 0.2s ease;
        }
        
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 4px;
            height: 100%;
            background: var(--primary);
            transition: width 0.2s;
        }
        
        .stat-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 24px rgba(0,0,0,0.08);
        }
        
        .stat-card:hover::before {
            width: 6px;
        }
        
        .stat-card.success::before { background: var(--status-success); }
        .stat-card.info::before { background: var(--status-info); }
        .stat-card.warning::before { background: #f59e0b; }
        .stat-card.danger::before { background: var(--status-error); }
        .stat-card.purple::before { background: var(--primary); }
        
        .stat-card h3 {
            margin: 0 0 8px;
            color: var(--text-muted);
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 600;
        }
        
        .stat-card .value {
            font-size: 1.85rem;
            font-weight: 700;
            color: var(--text);
            line-height: 1.2;
            font-feature-settings: 'tnum' 1;
        }
        
        .stat-card .subtext {
            font-size: 0.8rem;
            color: var(--text-muted);
            margin-top: 6px;
        }
        
        /* Chart Grid - Better spacing and cards */
        .chart-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
            margin-bottom: 28px;
        }
        
        @media (max-width: 992px) {
            .chart-grid {
                grid-template-columns: 1fr;
            }
        }
        
        .chart-card {
            background: var(--surface);
            border-radius: var(--radius-lg);
            padding: 24px;
            border: 1px solid var(--border);
            transition: box-shadow 0.2s;
        }
        
        .chart-card:hover {
            box-shadow: 0 4px 16px rgba(0,0,0,0.06);
        }
        
        .chart-card.full-width {
            grid-column: span 2;
        }
        
        @media (max-width: 992px) {
            .chart-card.full-width {
                grid-column: span 1;
            }
        }
        
        .chart-card h3 {
            margin: 0 0 20px;
            font-size: 1rem;
            font-weight: 600;
            color: var(--text);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .chart-card h3 .badge {
            font-size: 0.7rem;
            padding: 5px 12px;
            border-radius: 20px;
            background: rgba(67, 56, 202, 0.1);
            color: var(--primary);
            font-weight: 600;
        }
        
        .chart-container {
            position: relative;
            height: 280px;
        }
        
        .chart-container.small {
            height: 180px;
        }
        
        /* Data Tables - Enhanced readability */
        .data-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
        }
        
        .data-table th {
            padding: 14px 16px;
            text-align: left;
            font-weight: 600;
            color: var(--text);
            background: var(--bg);
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid var(--border);
            position: sticky;
            top: 0;
        }
        
        .data-table td {
            padding: 14px 16px;
            border-bottom: 1px solid var(--border);
            font-size: 0.9rem;
            color: var(--text);
        }
        
        .data-table tbody tr {
            transition: background 0.15s;
        }
        
        .data-table tbody tr:nth-child(even) {
            background: rgba(0,0,0,0.015);
        }
        
        .data-table tbody tr:hover {
            background: rgba(67, 56, 202, 0.04);
        }
        
        .data-table td small {
            color: var(--text-muted);
            display: block;
            margin-top: 2px;
        }
        
        /* Progress Bars - Smoother design */
        .progress-bar {
            height: 10px;
            background: var(--border);
            border-radius: 5px;
            overflow: hidden;
        }
        
        .progress-bar .fill {
            height: 100%;
            border-radius: 5px;
            transition: width 0.6s ease;
        }
        
        .progress-bar .fill.success { background: linear-gradient(90deg, #10b981, #34d399); }
        .progress-bar .fill.warning { background: linear-gradient(90deg, #f59e0b, #fbbf24); }
        .progress-bar .fill.danger { background: linear-gradient(90deg, #ef4444, #f87171); }
        .progress-bar .fill.info { background: linear-gradient(90deg, #3b82f6, #60a5fa); }
        
        /* Tabs - Pill style for modern look */
        .dashboard-tabs {
            display: flex;
            gap: 8px;
            margin-bottom: 24px;
            background: var(--surface);
            border-radius: var(--radius-lg);
            padding: 8px;
            border: 1px solid var(--border);
            flex-wrap: wrap;
        }
        
        .dashboard-tab {
            padding: 12px 20px;
            cursor: pointer;
            border-radius: var(--radius-md);
            color: var(--text-secondary);
            font-weight: 500;
            font-size: 0.9rem;
            transition: all 0.2s ease;
            background: transparent;
            border: none;
        }
        
        .dashboard-tab:hover {
            background: var(--bg);
            color: var(--primary);
        }
        
        .dashboard-tab.active {
            background: var(--primary);
            color: white;
            box-shadow: 0 2px 8px rgba(67, 56, 202, 0.3);
        }
        
        .tab-content {
            display: none;
            animation: fadeIn 0.3s ease;
        }
        
        .tab-content.active {
            display: block;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(8px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        /* Quick Links - Better styling */
        .quick-links {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 12px;
        }
        
        .quick-link {
            padding: 8px 16px;
            background: rgba(255,255,255,0.15);
            border-radius: var(--radius-md);
            text-decoration: none;
            color: rgba(255,255,255,0.9);
            font-size: 0.85rem;
            font-weight: 500;
            border: 1px solid rgba(255,255,255,0.2);
            transition: all 0.2s;
            backdrop-filter: blur(10px);
        }
        
        .quick-link:hover {
            background: white;
            color: var(--primary);
            border-color: white;
            transform: translateY(-1px);
        }
        
        /* Loading Overlay - Improved */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(255,255,255,0.95);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            backdrop-filter: blur(4px);
        }
        
        .loading-spinner {
            width: 48px;
            height: 48px;
            border: 3px solid var(--border);
            border-top-color: var(--primary);
            border-radius: 50%;
            animation: spin 0.8s linear infinite;
        }
        
        .loading-overlay::after {
            content: 'Loading dashboard...';
            margin-top: 16px;
            color: var(--text-muted);
            font-size: 0.9rem;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        .hidden {
            display: none !important;
        }
        
        /* Status badges - Refined design */
        .status-good { 
            background: rgba(16, 185, 129, 0.12); 
            color: #059669; 
            padding: 4px 12px; 
            border-radius: 20px; 
            font-size: 0.75rem; 
            font-weight: 600;
        }
        .status-warning { 
            background: rgba(245, 158, 11, 0.12); 
            color: #d97706; 
            padding: 4px 12px; 
            border-radius: 20px; 
            font-size: 0.75rem; 
            font-weight: 600;
        }
        .status-danger { 
            background: rgba(239, 68, 68, 0.12); 
            color: #dc2626; 
            padding: 4px 12px; 
            border-radius: 20px; 
            font-size: 0.75rem; 
            font-weight: 600;
        }
        .status-info { 
            background: rgba(59, 130, 246, 0.12); 
            color: #2563eb; 
            padding: 4px 12px; 
            border-radius: 20px; 
            font-size: 0.75rem; 
            font-weight: 600;
        }
        
        /* Revenue Summary - Grid layout improvements */
        .revenue-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 16px;
        }
        
        .revenue-item {
            padding: 16px;
            background: var(--bg);
            border-radius: var(--radius-md);
            border: 1px solid var(--border);
        }
        
        .revenue-item small {
            color: var(--text-muted);
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            display: block;
            margin-bottom: 6px;
        }
        
        .revenue-item h3 {
            margin: 0;
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text);
        }
        
        .revenue-item.positive h3 { color: #059669; }
        .revenue-item.negative h3 { color: #dc2626; }
        .revenue-item.warning h3 { color: #d97706; }
        
        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .dashboard-header {
                padding: 20px;
            }
            
            .dashboard-header h1 {
                font-size: 1.3rem;
            }
            
            .stats-row {
                grid-template-columns: repeat(2, 1fr);
                gap: 12px;
            }
            
            .stat-card {
                padding: 16px 14px;
            }
            
            .stat-card .value {
                font-size: 1.5rem;
            }
            
            .dashboard-tabs {
                padding: 6px;
            }
            
            .dashboard-tab {
                padding: 10px 14px;
                font-size: 0.8rem;
            }
            
            .chart-card {
                padding: 16px;
            }
            
            .header-controls {
                width: 100%;
                flex-wrap: wrap;
            }
            
            .header-controls select {
                flex: 1;
                min-width: 100px;
            }
        }
        
        @media (max-width: 480px) {
            .stats-row {
                grid-template-columns: 1fr;
            }
            
            .quick-links {
                flex-direction: column;
            }
            
            .quick-link {
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <div class="loading-overlay" id="loadingOverlay">
        <div class="loading-spinner"></div>
    </div>

    <header class="dashboard-header">
        <div>
            <h1>Analytics Dashboard</h1>
            <div class="quick-links">
                <a href="../index.php" class="quick-link">← Back to Students</a>
                <a href="finance.php" class="quick-link">Finance</a>
                <a href="scholarships.php" class="quick-link">Scholarships</a>
            </div>
        </div>
        <div class="header-controls">
            <label style="color: rgba(255,255,255,0.8);">Academic Year:</label>
            <select id="academicYear">
                <?php foreach ($academic_years as $ay): ?>
                    <option value="<?php echo $ay['academic_year']; ?>" <?php echo $ay['academic_year'] === $current_ay ? 'selected' : ''; ?>>
                        <?php echo $ay['academic_year']; ?>
                    </option>
                <?php endforeach; ?>
                <?php if (empty($academic_years)): ?>
                    <option value="<?php echo $current_ay; ?>"><?php echo $current_ay; ?></option>
                <?php endif; ?>
            </select>
            <select id="semester">
                <option value="">All Semesters</option>
                <option value="1">1st Semester</option>
                <option value="2">2nd Semester</option>
            </select>
            <button onclick="refreshData()" class="btn" style="background:white; color:#333;">Refresh</button>
        </div>
    </header>

    <div class="dashboard-container">
        <!-- Key Stats -->
        <div class="stats-row" id="statsRow">
            <div class="stat-card">
                <h3>Total Students</h3>
                <div class="value" id="statStudents">-</div>
                <div class="subtext" id="statStudentsSub">Active students</div>
            </div>
            <div class="stat-card success">
                <h3>Enrolled This Term</h3>
                <div class="value" id="statEnrolled">-</div>
                <div class="subtext">Currently enrolled</div>
            </div>
            <div class="stat-card info">
                <h3>Collection Rate</h3>
                <div class="value" id="statCollection">-</div>
                <div class="subtext" id="statCollectionSub">of assessed fees</div>
            </div>
            <div class="stat-card warning">
                <h3>Dean's Listers</h3>
                <div class="value" id="statDeans">-</div>
                <div class="subtext">Academic excellence</div>
            </div>
            <div class="stat-card danger">
                <h3>At Risk Students</h3>
                <div class="value" id="statRisk">-</div>
                <div class="subtext">Probation/Warning</div>
            </div>
            <div class="stat-card purple">
                <h3>Active Scholarships</h3>
                <div class="value" id="statScholarships">-</div>
                <div class="subtext">This term</div>
            </div>
        </div>

        <!-- Tabs -->
        <div class="dashboard-tabs">
            <div class="dashboard-tab active" onclick="showTab('overview')">Overview</div>
            <div class="dashboard-tab" onclick="showTab('enrollment')">Enrollment</div>
            <div class="dashboard-tab" onclick="showTab('grades')">Grade Distribution</div>
            <div class="dashboard-tab" onclick="showTab('retention')">Retention</div>
            <div class="dashboard-tab" onclick="showTab('revenue')">Revenue</div>
        </div>

        <!-- Tab: Overview -->
        <div id="tab-overview" class="tab-content active">
            <div class="chart-grid">
                <div class="chart-card">
                    <h3>Students by Program</h3>
                    <div class="chart-container">
                        <canvas id="chartPrograms"></canvas>
                    </div>
                </div>
                <div class="chart-card">
                    <h3>Students by Year Level</h3>
                    <div class="chart-container">
                        <canvas id="chartYearLevels"></canvas>
                    </div>
                </div>
                <div class="chart-card full-width">
                    <h3>Financial Overview <span class="badge" id="financialTerm">-</span></h3>
                    <div class="chart-container small">
                        <canvas id="chartFinancial"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tab: Enrollment -->
        <div id="tab-enrollment" class="tab-content">
            <div class="chart-grid">
                <div class="chart-card">
                    <h3>Enrollment by Program</h3>
                    <div class="chart-container">
                        <canvas id="chartEnrollProgram"></canvas>
                    </div>
                </div>
                <div class="chart-card">
                    <h3>Enrollment Trend</h3>
                    <div class="chart-container">
                        <canvas id="chartEnrollTrend"></canvas>
                    </div>
                </div>
                <div class="chart-card full-width">
                    <h3>Most Popular Courses</h3>
                    <div style="max-height: 300px; overflow-y: auto;">
                        <table class="data-table" id="tablePopularCourses">
                            <thead>
                                <tr>
                                    <th>Course Code</th>
                                    <th>Course Name</th>
                                    <th>Enrollments</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tab: Grade Distribution -->
        <div id="tab-grades" class="tab-content">
            <div class="chart-grid">
                <div class="chart-card">
                    <h3>Overall Grade Distribution</h3>
                    <div class="chart-container">
                        <canvas id="chartGrades"></canvas>
                    </div>
                </div>
                <div class="chart-card">
                    <h3>Pass/Fail Rate by Program</h3>
                    <div class="chart-container">
                        <canvas id="chartPassFail"></canvas>
                    </div>
                </div>
                <div class="chart-card full-width">
                    <h3>Top Performing Courses (Lowest Average Grade = Better)</h3>
                    <div style="max-height: 300px; overflow-y: auto;">
                        <table class="data-table" id="tableTopCourses">
                            <thead>
                                <tr>
                                    <th>Course</th>
                                    <th>Average Grade</th>
                                    <th>Students</th>
                                    <th>Performance</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tab: Retention -->
        <div id="tab-retention" class="tab-content">
            <div class="chart-grid">
                <div class="chart-card">
                    <h3>Student Status Distribution</h3>
                    <div class="chart-container">
                        <canvas id="chartStatus"></canvas>
                    </div>
                </div>
                <div class="chart-card">
                    <h3>Retention Rate by Cohort</h3>
                    <div class="chart-container">
                        <canvas id="chartRetention"></canvas>
                    </div>
                </div>
                <div class="chart-card full-width">
                    <h3>Students at Academic Risk</h3>
                    <div id="riskStudentsContainer">
                        <table class="data-table" id="tableRiskStudents">
                            <thead>
                                <tr>
                                    <th>Standing</th>
                                    <th>Count</th>
                                    <th>Action Needed</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Tab: Revenue -->
        <div id="tab-revenue" class="tab-content">
            <div class="chart-grid">
                <div class="chart-card">
                    <h3>Revenue Summary</h3>
                    <div id="revenueSummary" style="padding: 20px;">
                        <!-- Populated by JS -->
                    </div>
                </div>
                <div class="chart-card">
                    <h3>Collection Trend</h3>
                    <div class="chart-container">
                        <canvas id="chartRevenueTrend"></canvas>
                    </div>
                </div>
                <div class="chart-card full-width">
                    <h3>Scholarship Distribution</h3>
                    <div style="max-height: 300px; overflow-y: auto;">
                        <table class="data-table" id="tableScholarships">
                            <thead>
                                <tr>
                                    <th>Scholarship</th>
                                    <th>Recipients</th>
                                    <th>Discount</th>
                                </tr>
                            </thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Chart instances
        let charts = {};
        
        // Modern color palette - softer, more accessible colors
        const colors = {
            primary: ['#6366f1', '#10b981', '#3b82f6', '#f59e0b', '#ef4444', '#8b5cf6', '#ec4899', '#14b8a6'],
            light: ['rgba(99,102,241,0.15)', 'rgba(16,185,129,0.15)', 'rgba(59,130,246,0.15)'],
            gradient: function(ctx, color1, color2) {
                const gradient = ctx.createLinearGradient(0, 0, 0, 280);
                gradient.addColorStop(0, color1);
                gradient.addColorStop(1, color2);
                return gradient;
            }
        };
        
        // Chart.js global defaults for consistent styling
        Chart.defaults.font.family = "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif";
        Chart.defaults.font.size = 12;
        Chart.defaults.color = '#64748b';
        Chart.defaults.plugins.legend.labels.usePointStyle = true;
        Chart.defaults.plugins.legend.labels.padding = 16;
        
        // Initialize
        document.addEventListener('DOMContentLoaded', () => {
            refreshData();
        });
        
        // Tab switching
        function showTab(tabName) {
            document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
            document.querySelectorAll('.dashboard-tab').forEach(t => t.classList.remove('active'));
            document.getElementById('tab-' + tabName).classList.add('active');
            event.target.classList.add('active');
        }
        
        // Refresh all data
        async function refreshData() {
            const ay = document.getElementById('academicYear').value;
            const sem = document.getElementById('semester').value;
            
            showLoading(true);
            
            try {
                // Load all reports
                const [overview, enrollment, grades, retention, revenue] = await Promise.all([
                    fetchReport('overview', ay, sem),
                    fetchReport('enrollment', ay, sem),
                    fetchReport('grades', ay, sem),
                    fetchReport('retention', ay, sem),
                    fetchReport('revenue', ay, sem)
                ]);
                
                renderOverview(overview);
                renderEnrollment(enrollment);
                renderGrades(grades);
                renderRetention(retention);
                renderRevenue(revenue);
                
            } catch (e) {
                console.error('Error loading data:', e);
            } finally {
                showLoading(false);
            }
        }
        
        async function fetchReport(type, ay, sem) {
            const url = `../api/analytics.php?type=${type}&ay=${encodeURIComponent(ay)}${sem ? '&sem=' + sem : ''}`;
            const response = await fetch(url);
            return response.json();
        }
        
        function showLoading(show) {
            document.getElementById('loadingOverlay').classList.toggle('hidden', !show);
        }
        
        // Render Overview
        function renderOverview(data) {
            // Stats cards
            document.getElementById('statStudents').textContent = data.totals?.students || 0;
            document.getElementById('statEnrolled').textContent = data.quick_stats?.enrolled_this_term || 0;
            document.getElementById('statCollection').textContent = (data.financials?.collection_rate || 0) + '%';
            document.getElementById('statCollectionSub').textContent = '₱' + numberFormat(data.financials?.collected || 0) + ' collected';
            document.getElementById('statDeans').textContent = data.quick_stats?.deans_list || 0;
            document.getElementById('statRisk').textContent = data.quick_stats?.at_risk || 0;
            document.getElementById('statScholarships').textContent = data.totals?.scholarships_active || 0;
            document.getElementById('financialTerm').textContent = data.financials?.term || '-';
            
            // Programs chart
            renderChart('chartPrograms', 'doughnut', {
                labels: data.programs?.map(p => p.program_code) || [],
                datasets: [{
                    data: data.programs?.map(p => p.count) || [],
                    backgroundColor: colors.primary
                }]
            });
            
            // Year levels chart
            renderChart('chartYearLevels', 'bar', {
                labels: data.year_levels?.map(y => 'Year ' + y.year_level) || [],
                datasets: [{
                    label: 'Students',
                    data: data.year_levels?.map(y => y.count) || [],
                    backgroundColor: colors.primary[0]
                }]
            }, { indexAxis: 'y' });
            
            // Financial chart
            renderChart('chartFinancial', 'bar', {
                labels: ['Assessed', 'Collected', 'Balance'],
                datasets: [{
                    label: 'Amount (₱)',
                    data: [data.financials?.assessed || 0, data.financials?.collected || 0, data.financials?.balance || 0],
                    backgroundColor: [colors.primary[0], colors.primary[1], colors.primary[4]]
                }]
            });
        }
        
        // Render Enrollment
        function renderEnrollment(data) {
            // By program
            renderChart('chartEnrollProgram', 'pie', {
                labels: data.by_program?.map(p => p.program_code) || [],
                datasets: [{
                    data: data.by_program?.map(p => p.enrolled) || [],
                    backgroundColor: colors.primary
                }]
            });
            
            // Trend
            renderChart('chartEnrollTrend', 'line', {
                labels: data.trend?.map(t => t.academic_year) || [],
                datasets: [{
                    label: 'Total Enrolled',
                    data: data.trend?.map(t => t.total_enrolled) || [],
                    borderColor: colors.primary[0],
                    backgroundColor: colors.light[0],
                    fill: true,
                    tension: 0.3
                }]
            });
            
            // Popular courses table
            const tbody = document.querySelector('#tablePopularCourses tbody');
            tbody.innerHTML = (data.course_popularity || []).map(c => `
                <tr>
                    <td><strong>${c.course_code}</strong></td>
                    <td>${c.course_name}</td>
                    <td>${c.enrollments}</td>
                </tr>
            `).join('') || '<tr><td colspan="3" style="text-align:center;color:#999;">No data</td></tr>';
        }
        
        // Render Grades
        function renderGrades(data) {
            // Distribution - Using semantic colors for grades
            const gradeColors = ['#10b981', '#34d399', '#3b82f6', '#f59e0b', '#f97316', '#ef4444'];
            renderChart('chartGrades', 'doughnut', {
                labels: data.distribution?.map(d => d.label) || [],
                datasets: [{
                    data: data.distribution?.map(d => d.count) || [],
                    backgroundColor: gradeColors,
                    borderWidth: 2,
                    borderColor: '#fff'
                }]
            });
            
            // Pass/Fail by program
            renderChart('chartPassFail', 'bar', {
                labels: data.pass_fail_rate?.map(p => p.program_code) || [],
                datasets: [
                    {
                        label: 'Pass Rate %',
                        data: data.pass_fail_rate?.map(p => p.pass_rate) || [],
                        backgroundColor: colors.primary[1]
                    }
                ]
            });
            
            // Top courses table
            const tbody = document.querySelector('#tableTopCourses tbody');
            tbody.innerHTML = (data.top_performing_courses || []).map(c => {
                const avgGrade = parseFloat(c.avg_grade);
                let status = 'status-good';
                let label = 'Excellent';
                if (avgGrade > 2.0) { status = 'status-warning'; label = 'Good'; }
                if (avgGrade > 2.5) { status = 'status-info'; label = 'Average'; }
                if (avgGrade > 3.0) { status = 'status-danger'; label = 'Needs Improvement'; }
                
                return `
                    <tr>
                        <td><strong>${c.course_code}</strong><br><small>${c.course_name}</small></td>
                        <td>${avgGrade.toFixed(2)}</td>
                        <td>${c.students}</td>
                        <td><span class="${status}">${label}</span></td>
                    </tr>
                `;
            }).join('') || '<tr><td colspan="4" style="text-align:center;color:#999;">No data</td></tr>';
        }
        
        // Render Retention
        function renderRetention(data) {
            // Status distribution
            renderChart('chartStatus', 'doughnut', {
                labels: data.current_status?.map(s => s.status) || [],
                datasets: [{
                    data: data.current_status?.map(s => s.count) || [],
                    backgroundColor: [colors.primary[1], colors.primary[4], colors.primary[0]]
                }]
            });
            
            // Retention by cohort
            const cohorts = data.retention_by_cohort || [];
            renderChart('chartRetention', 'bar', {
                labels: cohorts.map(c => c.cohort_year),
                datasets: [
                    {
                        label: 'Retention %',
                        data: cohorts.map(c => c.retention_rate),
                        backgroundColor: colors.primary[1]
                    },
                    {
                        label: 'Graduation %',
                        data: cohorts.map(c => c.graduation_rate),
                        backgroundColor: colors.primary[0]
                    }
                ]
            });
            
            // Risk students table
            const tbody = document.querySelector('#tableRiskStudents tbody');
            tbody.innerHTML = (data.at_risk || []).map(r => {
                let action = 'Academic counseling recommended';
                if (r.standing === 'Probation') action = 'Immediate intervention required';
                if (r.standing === 'Dismissed') action = 'Review for possible readmission';
                
                return `
                    <tr>
                        <td><span class="status-danger">${r.standing}</span></td>
                        <td><strong>${r.count}</strong> students</td>
                        <td>${action}</td>
                    </tr>
                `;
            }).join('') || '<tr><td colspan="3" style="text-align:center;color:#999;">No at-risk students</td></tr>';
        }
        
        // Render Revenue
        function renderRevenue(data) {
            const summary = data.summary || {};
            
            // Summary card - Using improved revenue grid
            document.getElementById('revenueSummary').innerHTML = `
                <div class="revenue-grid">
                    <div class="revenue-item">
                        <small>Gross Assessment</small>
                        <h3>₱${numberFormat(summary.gross_assessment || 0)}</h3>
                    </div>
                    <div class="revenue-item negative">
                        <small>Scholarships Discount</small>
                        <h3>-₱${numberFormat(summary.total_discount || 0)}</h3>
                    </div>
                    <div class="revenue-item">
                        <small>Net Assessment</small>
                        <h3>₱${numberFormat(summary.net_assessment || 0)}</h3>
                    </div>
                    <div class="revenue-item positive">
                        <small>Total Collected</small>
                        <h3>₱${numberFormat(summary.total_collected || 0)}</h3>
                    </div>
                    <div class="revenue-item warning">
                        <small>Outstanding Balance</small>
                        <h3>₱${numberFormat(summary.balance || 0)}</h3>
                    </div>
                    <div class="revenue-item negative">
                        <small>Late Fees</small>
                        <h3>₱${numberFormat(summary.late_fees || 0)}</h3>
                    </div>
                </div>
                <div style="margin-top:20px; padding: 16px; background: var(--bg); border-radius: var(--radius-md); border: 1px solid var(--border);">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
                        <small style="color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; font-weight: 600;">Collection Rate</small>
                        <span style="font-weight: 700; color: var(--primary);">${summary.collection_rate || 0}%</span>
                    </div>
                    <div class="progress-bar">
                        <div class="fill ${summary.collection_rate >= 80 ? 'success' : summary.collection_rate >= 50 ? 'warning' : 'danger'}" 
                             style="width: ${summary.collection_rate || 0}%"></div>
                    </div>
                </div>
            `;
            
            // Trend chart
            renderChart('chartRevenueTrend', 'line', {
                labels: data.by_term?.map(t => t.academic_year + ' S' + t.semester) || [],
                datasets: [{
                    label: 'Collected (₱)',
                    data: data.by_term?.map(t => t.collected) || [],
                    borderColor: colors.primary[1],
                    backgroundColor: colors.light[1],
                    fill: true,
                    tension: 0.3
                }]
            });
            
            // Scholarships table
            const tbody = document.querySelector('#tableScholarships tbody');
            tbody.innerHTML = (data.scholarships_impact || []).map(s => `
                <tr>
                    <td><strong>${s.name}</strong><br><small>${s.code}</small></td>
                    <td>${s.recipients}</td>
                    <td>${s.discount_type === 'percentage' ? s.discount_value + '%' : '₱' + numberFormat(s.discount_value)}</td>
                </tr>
            `).join('') || '<tr><td colspan="3" style="text-align:center;color:#999;">No scholarships awarded</td></tr>';
        }
        
        // Render Chart helper - Enhanced with modern styling
        function renderChart(canvasId, type, data, options = {}) {
            const ctx = document.getElementById(canvasId);
            if (!ctx) return;
            
            // Destroy existing chart
            if (charts[canvasId]) {
                charts[canvasId].destroy();
            }
            
            const defaultOptions = {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    legend: {
                        position: type === 'doughnut' || type === 'pie' ? 'right' : 'top',
                        labels: {
                            boxWidth: 12,
                            padding: 16
                        }
                    },
                    tooltip: {
                        backgroundColor: 'rgba(30, 41, 59, 0.95)',
                        titleColor: '#fff',
                        bodyColor: '#e2e8f0',
                        padding: 12,
                        cornerRadius: 8,
                        displayColors: true,
                        boxPadding: 4
                    }
                },
                scales: type === 'bar' || type === 'line' ? {
                    x: {
                        grid: {
                            display: false
                        },
                        ticks: {
                            padding: 8
                        }
                    },
                    y: {
                        grid: {
                            color: 'rgba(0, 0, 0, 0.05)'
                        },
                        ticks: {
                            padding: 8
                        }
                    }
                } : {}
            };
            
            // Doughnut/Pie specific options
            if (type === 'doughnut' || type === 'pie') {
                defaultOptions.cutout = type === 'doughnut' ? '65%' : 0;
                defaultOptions.plugins.legend.position = 'right';
            }
            
            // Merge scales properly
            const mergedOptions = { ...defaultOptions, ...options };
            if (options.scales) {
                mergedOptions.scales = { ...defaultOptions.scales, ...options.scales };
            }
            
            charts[canvasId] = new Chart(ctx, {
                type: type,
                data: data,
                options: mergedOptions
            });
        }
        
        // Number formatting
        function numberFormat(num) {
            return parseFloat(num || 0).toLocaleString('en-PH', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
        }
        
        // Auto-refresh on filter change
        document.getElementById('academicYear').addEventListener('change', refreshData);
        document.getElementById('semester').addEventListener('change', refreshData);
    </script>
</body>
</html>
