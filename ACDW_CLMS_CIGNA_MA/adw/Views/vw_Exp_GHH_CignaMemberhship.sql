



CREATE VIEW [adw].[vw_Exp_GHH_CignaMemberhship]

AS
/* Purpose: Gets all Active members with MPI/Ace ID for Export to 3rd parties 
			 Used by GHH Export file creation ETL: Ghh-Exp-ActiveMembers.dtsx
     History: GK created 11/14/2019

			 */  	 
			 
    SELECT DISTINCT 
	Dim.ACE_ID AS AceID,
	vwMbr.MEMBER_LAST_NAME AS LAST_NAME,
	vwMbr.MEMBER_FIRST_NAME AS FIRST_NAME,
	vwMbr.MEMBER_MI AS MIDDLE_NAME,
	vwMbr.MEMBER_GENDER AS GENDER,
	CONVERT(VARCHAR(8), vwMbr.DATE_OF_BIRTH, 112) AS DATE_OF_BIRTH,
	''	AS SSN ,
	vwMbr.[HOME_ADDRESS] AS MEMBER_HOME_ADDRESS,
	''  AS MEMBER_HOME_ADDRESS2,
	vwMbr.[HOME_CITY] AS MEMBER_HOME_CITY,
	vwMbr.[HOME_STATE] AS MEMBER_HOME_STATE,
	vwMbr.[HOME_ZIPCODE] AS MEMBER_HOME_ZIP,
	vwMbr.HOME_PHONE AS Member_Home_Phone,
	CONVERT(VARCHAR(8), DATEADD(DAY, -45, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()) , 1)),112) MinEligDate, 
    CONVERT(VARCHAR(8), DATEADD(MONTH, 6, DATEADD(Day, -1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()) , 1))),112) MinExpDate,
	Dim.ClientMemberKey AS ClientMemberKey	,
	Dim.ClientKey   

	From [adw].[DimCignaMAMemberKeys] Dim Right join [dbo].[tmp_VW_AH_MEMBERSHIP]  vwMbr
    ON REPLACE(dim.[ClientMemberKey], '*','') = vwMbr.[Member_ID]

--	FROM  [dbo].[tmp_VW_AH_MEMBERSHIP] Mbr LEFT JOIN [adw].[DimCignaMAMemberKeys] DimMbrKey
--	ON Mbr.[Member_ID] = DimMbrKey.ClientMemberKey
	
				           
  --  SELECT DISTINCT 
  --          RTRIM(LTRIM(ISNULL(am.Ace_ID, '')))				 AS AceID			 -- Ace MRN
  --        , RTRIM(LTRIM(ISNULL(AM.MEMBER_LAST_NAME, '')))		 AS LAST_NAME		 -- name limit 50 char
		--, RTRIM(LTRIM(ISNULL(AM.MEMBER_FIRST_NAME,'')))		 AS FIRST_NAME		 -- name limit 50 char
  --        , RTRIM(LTRIM(ISNULL(AM.MEMBER_MI, '')))				 AS MIDDLE_NAME	 -- name limit 50 char
		--, CASE WHEN (RTRIM(LTRIM(am.Gender)) = 'M') THEN 'M'
		--	  WHEN (RTRIM(LTRIM(am.Gender)) = 'F') THEN 'F'
		--	  ELSE 'U' END 					 AS GENDER		 -- Gender Limit 1 char
  --        , CONVERT(VARCHAR(8), am.DATE_OF_BIRTH, 112)  AS DATE_OF_BIRTH	 -- DOB 8 Char
		--, ''									 AS SSN
		--, RTRIM(LTRIM(ISNULL(am.MEMBER_HOME_ADDRESS,'')))		 AS MEMBER_HOME_ADDRESS
  --        , RTRIM(LTRIM(ISNULL(am.MEMBER_HOME_ADDRESS2,'')))	 AS MEMBER_HOME_ADDRESS2
  --        , RTRIM(LTRIM(ISNULL(am.MEMBER_HOME_CITY,'')))		 AS MEMBER_HOME_CITY
  --        , CASE WHEN ISNULL(am.MEMBER_HOME_STATE,'') = '' THEN ''
		--    WHEN [State].StateAbreviation IS NULL THEN ''
		--	 ELSE [State].StateAbreviation END		 AS MEMBER_HOME_STATE		
  --        , ISNULL(am.MEMBER_HOME_ZIP_C, '')					 AS MEMBER_HOME_ZIP
		--, ISNULL([adw].[AceCleanPhoneNumber](am.Member_Home_Phone),'')		 AS Member_Home_Phone
		--, CONVERT(VARCHAR(8), DATEADD(DAY, -45, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()) , 1)),112) MinEligDate
		--, CONVERT(VARCHAR(8), DATEADD(MONTH, 6, DATEADD(Day, -1, DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()) , 1))),112) MinExpDate
		--, RTRIM(LTRIM(am.MEMBER_ID))				 AS ClientMemberKey	
		--, am.clientKey    
  --   FROM dbo.vw_ActiveMembers AS AM
	 --  LEFT JOIN lst.lstState [State] ON AM.MEMBER_HOME_STATE = [State].StateAbreviation
	










