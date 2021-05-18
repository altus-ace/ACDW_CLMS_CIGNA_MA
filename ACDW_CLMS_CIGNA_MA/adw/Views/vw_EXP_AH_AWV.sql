
CREATE VIEW [adw].[vw_EXP_AH_AWV]
AS 
SELECT  
    awv.CignaMA_AWVKey AdiKey
    , AWV.FileDate AS LoadDate
    , Client.ClientKey , client.CS_Export_LobName	  	 
    , clean.ClientSubscriberId			 AS Member_id 
    , 'C-Annual Wellness Visit'	 AS Program_Name 
    , '9/9/2020'						 AS  StartDate    
    , '12/31/2020'						 AS EndDate    
    , 'ACTIVE'					 AS PROGRAM_STATUS
    , 'Enrolled in a Program'		 AS REASON_DESCRIPTION
    , Client.cs_export_lobName	 AS REFERAL_TYPE
    
FROM ACDW_CLMS_CIGNA_MA.adi.CignaMA_AWV AWV
    JOIN (SELECT awv.memberid , REPLACE(AWV.memberid,'*', '')  AS ClientSubscriberId FROM ACDW_CLMS_CIGNA_MA.adi.CignaMA_AWV AWV) clean on awv.memberid = clean.memberid
    JOIN lst.List_Client Client ON 12 = Client.ClientKey
    JOIN ACECAREDW.adw.MbrMember mbr ON mbr.ClientKey  = 12 and mbr.ClientMemberKey = clean.ClientSubscriberId
--    JOIN ACECaredw.adw.mbrCsPlanHistory cs 
--	   ON mbr.mbrMemberKey = cs.MbrMemberKey 
WHERE client.ClientKey = 12
