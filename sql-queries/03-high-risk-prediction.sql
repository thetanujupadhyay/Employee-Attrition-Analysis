-- High-Risk Employee Identification
-- Predictive model identifying 25 current employees at risk of leaving

WITH risk_analysis AS (
    SELECT 
        EmpID,
        FirstName,
        LastName,
        Title,
        BusinessUnit,
        DepartmentType,
        Supervisor,
        GenderCode,
        MaritalDesc,
        
        -- Risk scoring based on department patterns discovered
        CASE 
            WHEN DepartmentType = 'Production       ' THEN 3  -- High risk dept
            WHEN DepartmentType = 'IT/IS' AND BusinessUnit IN ('MSC', 'BPC', 'PYZ', 'CCDR') THEN 2  -- IT depts with firing issues
            ELSE 1
        END as DepartmentRisk,
        
        -- Business unit risk based on analysis
        CASE 
            WHEN BusinessUnit IN ('NEL', 'BPC', 'TNS') THEN 2  -- Highest attrition business units
            ELSE 1
        END as BusinessUnitRisk,
        
        -- Demographic risk
        CASE 
            WHEN GenderCode = 'M' THEN 1
            ELSE 1
        END as DemographicRisk
        
    FROM `employee-attrition-analysis.hr_analytics.employee_data`
    WHERE EmployeeStatus = 'Active'
)
SELECT 
    EmpID,
    FirstName,
    LastName,
    Title,
    BusinessUnit,
    DepartmentType,
    Supervisor,
    
    (DepartmentRisk + BusinessUnitRisk + DemographicRisk) as TotalRiskScore,
    
    CASE 
        WHEN (DepartmentRisk + BusinessUnitRisk + DemographicRisk) >= 6 THEN 'HIGH RISK - Take Action Now!'
        WHEN (DepartmentRisk + BusinessUnitRisk + DemographicRisk) >= 4 THEN 'MEDIUM RISK - Monitor Closely'
        ELSE 'Low Risk'
    END as RiskLevel
    
FROM risk_analysis
WHERE (DepartmentRisk + BusinessUnitRisk + DemographicRisk) >= 4
ORDER BY TotalRiskScore DESC, BusinessUnit, DepartmentType
LIMIT 25;
