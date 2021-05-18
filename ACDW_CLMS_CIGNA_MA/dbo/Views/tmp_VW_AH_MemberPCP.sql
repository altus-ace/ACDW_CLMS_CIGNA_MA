

CREATE VIEW [dbo].[tmp_VW_AH_MemberPCP]
AS
	 SELECT distinct
	 replace(memberid,'*','') AS MEMBER_ID,
	 NPID as MEMBER_PCP,
	 'PCP' PROVIDER_RELATIONSHIP_TYPE,
	 'CIGNA MA' as LOB,
	convert(date,dateadd(m,datediff(m,0,getdate()),0)) as PCP_EFFECTIVE_DATE,
	 '2099-12-31' as PCP_TERM_DATE,
	 'A' as MEMBER_PCP_ADDITIONAL_INFORMATION_1 --Add

	 from [ACDW_CLMS_CIGNA_MA].[adi].[tmp_CignaMAMembership] a
	 join ACECAREDW.adw.fctProviderRoster b on b.NPI = a.npid and b.ClientKey = 12 and IsActive = 1 and getdate() between B.EffectiveDate and B.ExpirationDate
	 where a.datadate = (select max(datadate) from ACDW_CLMS_CIGNA_MA.adi.tmp_cignamamembership)
