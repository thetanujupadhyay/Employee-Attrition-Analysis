-- Department Attrition Analysis
-- Identified Production departments as highest risk (14-19% attrition)

SELECT 
    BusinessUnit,
    DepartmentType,
    COUNT(*) as TotalEmployees,
    COUNTIF(EmployeeStatus = 'Active') as ActiveEmployees,
    COUNTIF(EmployeeStatus LIKE '%Terminated%') as TotalTerminations,
    COUNTIF(EmployeeStatus = 'Voluntarily Terminated') as VoluntaryTerminations,
    COUNTIF(EmployeeStatus = 'Terminated for Cause') as InvoluntaryTerminations,
    
    -- Attrition rate by department
    ROUND((COUNTIF(EmployeeStatus LIKE '%Terminated%') * 100.0 / COUNT(*)), 2) as AttritionRate_Percent,
    
    -- Voluntary vs involuntary breakdown
    ROUND((COUNTIF(EmployeeStatus = 'Voluntarily Terminated') * 100.0 / NULLIF(COUNTIF(EmployeeStatus LIKE '%Terminated%'), 0)), 2) as PercentVoluntary,
    
    -- Rank departments by attrition rate  
    RANK() OVER (ORDER BY (COUNTIF(EmployeeStatus LIKE '%Terminated%') * 100.0 / COUNT(*)) DESC) as WorstDepartmentRank
    
FROM `employee-attrition-analysis.hr_analytics.employee_data`
GROUP BY BusinessUnit, DepartmentType
HAVING COUNT(*) >= 20  -- Only departments with at least 20 employees
ORDER BY AttritionRate_Percent DESC;
