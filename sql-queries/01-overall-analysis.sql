-- Overall Attrition Analysis
-- Analyzed 3,000 employee records to identify company-wide attrition patterns

SELECT 
    COUNT(*) as TotalEmployees,
    COUNTIF(EmployeeStatus = 'Active') as ActiveEmployees,
    COUNTIF(EmployeeStatus = 'Voluntarily Terminated') as VoluntaryTerminations,
    COUNTIF(EmployeeStatus = 'Terminated for Cause') as InvoluntaryTerminations,
    COUNTIF(EmployeeStatus LIKE '%Terminated%') as TotalTerminations,
    
    -- Calculate attrition rate
    ROUND((COUNTIF(EmployeeStatus LIKE '%Terminated%') * 100.0 / COUNT(*)), 2) as OverallAttritionRate_Percent,
    
    -- Voluntary vs Involuntary breakdown
    ROUND((COUNTIF(EmployeeStatus = 'Voluntarily Terminated') * 100.0 / COUNTIF(EmployeeStatus LIKE '%Terminated%')), 2) as PercentVoluntary,
    ROUND((COUNTIF(EmployeeStatus = 'Terminated for Cause') * 100.0 / COUNTIF(EmployeeStatus LIKE '%Terminated%')), 2) as PercentInvoluntary,
    
    -- Performance insights
    ROUND(AVG(SAFE_CAST(`Performance Score` as FLOAT64)), 2) as AvgPerformanceScore
    
FROM `employee-attrition-analysis.hr_analytics.employee_data`;
