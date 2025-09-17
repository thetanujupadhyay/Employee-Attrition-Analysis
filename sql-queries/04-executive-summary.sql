-- Executive Summary Dashboard
-- Key metrics and findings for C-suite presentation

SELECT 
    '📊 EMPLOYEE ATTRITION ANALYSIS - EXECUTIVE SUMMARY' as ReportTitle,
    
    -- Overall Company Metrics
    CONCAT('Total Employees Analyzed: ', CAST(COUNT(*) as STRING)) as CompanySize,
    CONCAT('Overall Attrition Rate: ', CAST(ROUND((COUNTIF(EmployeeStatus LIKE '%Terminated%') * 100.0 / COUNT(*)), 2) as STRING), '%') as AttritionRate,
    CONCAT('Total Terminations: ', CAST(COUNTIF(EmployeeStatus LIKE '%Terminated%') as STRING)) as TotalTerminations,
    CONCAT('Voluntary vs Involuntary: ', CAST(COUNTIF(EmployeeStatus = 'Voluntarily Terminated') as STRING), ' vs ', CAST(COUNTIF(EmployeeStatus = 'Terminated for Cause') as STRING)) as VoluntaryVsInvoluntary,
    
    -- Critical Findings
    'Highest Risk Department: Production (14-19% attrition across business units)' as HighestRiskDept,
    'Worst Business Unit: NEL Production (19.21% attrition)' as WorstBusinessUnit,
    'IT Problem Pattern: Most IT terminations are involuntary (fired vs quit)' as ITInsight,
    'High-Risk Current Employees Identified: 25 (need immediate retention action)' as RiskPrediction

FROM `employee-attrition-analysis.hr_analytics.employee_data`;
