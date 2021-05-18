

CREATE VIEW [dbo].[tmp_vw_AH_Eligibility]
AS 
	select
	distinct
	 replace(memberid, '*','' ) as MEMBER_ID,
	'CIGNA MA' as LOB,
	plan_name as BENEFIT_PLAN,
	 'E'  as [INTERNAL EXTERNAL INDICATOR],---External Source for the record
	--convert(date, effectivedate) as  START_DATE,
	convert(date,DATEADD(m, DATEDIFF(m, 0, GETDATE()), 0)) as  START_DATE,
	'2099-12-31' END_DATE
	from [ACDW_CLMS_CIGNA_MA].[adi].[tmp_CignaMAMembership] m
	join ACECAREDW.adw.fctProviderRoster b on b.NPI = m.npid and b.ClientKey = 12 and IsActive = 1 and getdate() between B.EffectiveDate and B.ExpirationDate
	where m.datadate=(select max(datadate) from [ACDW_CLMS_CIGNA_MA].[adi].[tmp_CignaMAMembership] )

	

