CREATE VIEW [dbo].[tmp_VW_AH_PROGRAMENROLLMENT]
AS
     SELECT DISTINCT 
            'CIGNA_MA' AS Client_id, 
            'Newly Enrolled' AS Program_Name, 
            CONVERT(DATE, DATEADD(m, DATEDIFF(m, 0, GETDATE()), 0)) AS Enroll_date, 
            CONVERT(DATE, DATEADD(m, DATEDIFF(m, 0, GETDATE()), 0)) AS Create_date, 
            REPLACE(memberid, '*', '') AS Member_id, 
            CONVERT(DATE, DATEADD(d, DATEDIFF(d, 0, GETDATE()), 90)) AS Enroll_END_DATE, 
            'ACTIVE' AS PROGRAM_STATUS, 
            'Enrolled in a Program' AS REASON_DESCRIPTION, 
            'Cigna_MA' AS REFERAL_TYPE
     FROM [ACDW_CLMS_CIGNA_MA].[adi].[tmp_CignaMAMembership] m
          JOIN ACECAREDW.adw.fctProviderRoster b ON b.NPI = m.npid
                                                    AND b.ClientKey = 12
                                                    AND IsActive = 1
                                                    AND GETDATE() BETWEEN B.EffectiveDate AND B.ExpirationDate
     WHERE m.datadate =
     (
         SELECT MAX(datadate)
         FROM [ACDW_CLMS_CIGNA_MA].[adi].[tmp_CignaMAMembership]
     );
