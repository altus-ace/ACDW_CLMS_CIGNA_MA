-- =============================================
-- Author:		Bing Yu
-- Create date: 09/08/2020
-- Description:	Insert Cigna MA AWV to DB
-- ============================================
CREATE PROCEDURE [adi].[ImportCignaMA_AWV]
	@memberid [varchar](50) ,
	@effectivedate varchar(20) ,
	@medicareid [varchar](50) ,
	@lastname [varchar](50) ,
	@firstname [varchar](50) ,
	@middlename [varchar](50) ,
	@gender [varchar](50) ,
	@DOB varchar(20),
	@Age [varchar](50) ,
	@AddressLine1 [varchar](50) ,
	@addressline2 [varchar](50) ,
	@city [varchar](50) ,
	@state [varchar](50) ,
	@zip [varchar](50) ,
	@homephone [varchar](50) ,
	@lastpcpvisit [varchar](50),
	@pcpid [varchar](50) ,
	@PCPName [varchar](50) ,
	@NPID [varchar](50) ,
	@PCPCounty [varchar](50) ,
	@hpcode [varchar](50) ,
	@pod_name [varchar](50) ,
	@pod_abbrev [varchar](50) ,
	@region [varchar](50) ,
	@County [varchar](50) ,
	@program [varchar](50) ,
	@diseasestate [varchar](50) ,
	@dualeligibility [varchar](50) ,
	@Risk_Score [varchar](10) ,
	@PCPCopay [varchar](50) ,
	@groupid [varchar](50) ,
	@plan_name [varchar](50) ,
	@regioncode [varchar](50) ,
	@Hcode [varchar](50) ,
	@LanguageDesc [varchar](50),
	@SrcFileName [varchar](50) ,
	--[CreatedDate] [datetime] NULL,
	@DataDate varchar(10),
	@CreateBy [varchar](50) ,
--	@LastUpdatedDate [datetime] ,
	@LastUpdatedBy [varchar](50)
	
            
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--	DECLARE @PInsuranceClaimNumberStartDTS varchar(10), @PInsuranceClaimNumberEndDTS varchar(10)
	--SET @PInsuranceClaimNumberStartDTS = SUBSTRING(@PreviousHealthInsuranceClaimNumberStartDTS, 1, 10)
	--SET @PInsuranceClaimNumberEndDTS = SUBSTRING(@PreviousHealthInsuranceClaimNumberEndDTS, 1,10)
	DECLARE @IntDOB varchar(10), @Inteffectdate varchar(10)
	--SET @Inteffectdate = SUBSTRING(@effectivedate, 1, 10)
	--PATINDEX('% %', @effectivedate)
	--SET @IntDOB = SUBSTRING(@DOB, 1, 10)
	--PATINDEX('% %', @DOB)
 

    IF(LEN(@memberid)> 0 )	
	BEGIN
    INSERT INTO [adi].[CignaMA_AWV]
    (
	[memberid] ,
	[effectivedate] ,
	[medicareid] ,
	[lastname] ,
	[firstname] ,
	[middlename] ,
	[gender] ,
	[DOB] ,
	[Age] ,
	[AddressLine1] ,
	[addressline2] ,
	[city] ,
	[state] ,
	[zip] ,
	[homephone] ,
	[lastpcpvisit] ,
	[pcpid] ,
	[PCPName] ,
	[NPID] ,
	[PCPCounty] ,
	[hpcode] ,
	[pod_name] ,
	[pod_abbrev] ,
	[region] ,
	[County] ,
	[program] ,
	[diseasestate] ,
	[dualeligibility] ,
	[Risk_Score] ,
	[PCPCopay] ,
	[groupid] ,
	[plan_name] ,
	[regioncode] ,
	[Hcode] ,
	[LanguageDesc] ,
	[SrcFileName] ,
	[CreatedDate] ,
	[DataDate],
	[FileDate],
	[CreateBy],
	LastUpdatedDate,
	LastUpdatedBy 

	)
		
 VALUES  (
   	@memberid ,
	CASE WHEN @effectivedate = ''
	THEN NULL
	ELSE CONVERT(DATE, @effectivedate)
	END ,
	@medicareid ,
	@lastname ,
	@firstname,
	@middlename ,
	@gender ,
	CASE WHEN @DOB = ''
	THEN NULL
	ELSE CONVERT(DATE, @DOB)
	END ,
	@Age ,
	@AddressLine1 ,
	@addressline2 ,
	@city ,
	@state ,
	@zip ,
	@homephone ,
	@lastpcpvisit ,
	@pcpid ,
	@PCPName ,
	@NPID ,
	@PCPCounty ,
	@hpcode ,
	@pod_name ,
	@pod_abbrev ,
	@region ,
	@County ,
	@program ,
	@diseasestate ,
	@dualeligibility ,
	@Risk_Score ,
	@PCPCopay ,
	@groupid ,
	@plan_name ,
	@regioncode ,
	@Hcode ,
	@LanguageDesc ,
	@SrcFileName ,
	GETDATE(),
	CONVERT(DATE,@DataDate),
	CONVERT(DATE,@DataDate),
	--[CreatedDate] [datetime] NULL,
	@CreateBy, 
	GETDATE(),
	--	@LastUpdatedDate [datetime] ,
	@LastUpdatedBy 
)

END

  --BEGIN
 --  SET @ActionStopDateTime = GETDATE()
 --  EXEC amd.sp_AceEtlAuditClose  @AuditID, @ActionStopDateTime, 1,1,0,2   	
 -- END TRY



  --BEGIN CATCH 

  -- SET @ActionStopDateTime = GETDATE()
  -- EXEC amd.sp_AceEtlAuditClose  @AuditID, @ActionStopDateTime, 1,1,0,3   	

  --END CATCH 
    
END


