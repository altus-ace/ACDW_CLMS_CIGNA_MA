-- =============================================
-- Author:		Bing Yu
-- Create date: 04/08/2020
-- Description:	Insert Membership to DB
-- ============================================
CREATE PROCEDURE [adi].[ImportCignaMACareOpps]

	@SrcFileName [varchar](100) ,
	--@LoadDate [date] ,
	@DataDate varchar(10),
	--[CreatedDate] [datetime] NOT NULL,
	@CreatedBy [varchar](50),
	--@LastUpdatedDate [datetime] NOT NULL,
	@LastUpdatedBy [varchar](50) ,
    @DOS_Yr varchar(10),
	@Op_Mkt varchar(10),
    @H_Plan varchar(10) ,
	@Mkt_Specific varchar(10) ,
	@P4Q varchar(10),
	@Living_Well varchar(50),
	@Mbr_Dcsd varchar(50),
	@Term_Date varchar(15),
	@POD varchar(50),
	@PCP_Name varchar(50) ,
	@Mbr_ID varchar(50) ,
	@Mbr_Name varchar(50),
	@Mbr_Dob varchar(10),
	@OPP_SCORE varchar(50),
	@BMI varchar(10),
	@BCS varchar(10),
	@COAFS varchar(10),
	@COAMR  varchar(10),
	@COAPA varchar(10) ,
	@COLO varchar(10),
	@DRE varchar(10) ,
	@A1c varchar(10) ,
	@NEPH varchar(10) ,
	@CBP varchar(10) ,
	@MRP varchar(10) ,
	@PCR varchar(10) ,
	@OSTEO varchar(10) ,
	@DMARD varchar(10) ,
	@ODB varchar(10) ,
	@ACEARB varchar(10) ,
	@STAT varchar(10) ,
	@SUPD varchar(10),
	@SPC varchar(10) ,
	@Mbr_Phn varchar(10) ,
    @PCP_ID varchar(50) ,
	@PCP_NPI varchar(50) ,
	@PCP_Phn varchar(50) ,
	@Last_Screening_DOS varchar(40) ,
	@Provider_Name varchar(50) ,
	@RISK_SCORE varchar(50),
	@AttrPCPID varchAR(50) ,
	@AttrPCPName VARCHAR(50) ,
	@AttrPOD VARCHAR(50) ,
	@CM_Flag VARCHAR(50) ,
	@RiskScoreGroup VARCHAR(50) ,
	@OPPScoreGroup VARCHAR(50) 

	
	
            
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF(LEN(@DOS_Yr) != 0 OR @DOS_Yr != 'DOS_Yr')
	BEGIN	
    INSERT INTO [adi].[CignaMACareOpps]
    (
	[SrcFileName] ,
	[LoadDate] ,
	[DataDate] ,
	[CreatedDate] ,
	[CreatedBy] ,
	[LastUpdatedDate] ,
	[LastUpdatedBy] ,
    DOS_Yr ,
	Op_Mkt ,
    H_Plan ,
	Mkt_Specific ,
	P4Q ,
	Living_Well ,
	Mbr_Dcsd ,
	Term_Date ,
	POD ,
	PCP_Name ,
	Mbr_ID ,
	Mbr_Name ,
	Mbr_Dob ,
	OPP_SCORE ,
	BMI ,
	BCS ,
	COAFS ,
	COAMR  ,
	COAPA ,
	COLO ,
	DRE ,
	A1c ,
	NEPH ,
	CBP ,
	MRP ,
	PCR ,
	OSTEO ,
	DMARD ,
	ODB ,
	ACEARB ,
	STAT ,
	SUPD ,
	SPC ,
	Mbr_Phn ,
    PCP_ID ,
	PCP_NPI ,
	PCP_Phn ,
	Last_Screening_DOS ,
	Provider_Name ,
	RISK_SCORE ,
	AttrPCPID ,
	AttrPCPName ,
	AttrPOD ,
	CM_Flag ,
	RiskScoreGroup ,
	OPPScoreGroup 
	)
		
 VALUES  (
   	@SrcFileName  ,
	GETDATE(),
	--@LoadDate [date] ,
	CASE WHEN @DataDate = ''
	THEN NULL
	ELSE CONVERT(DATE,@DataDate)
	END,
	--[CreatedDate] [datetime] NOT NULL,
	GETDATE(),
	@CreatedBy ,
	GETDATE(),
	--@LastUpdatedDate [datetime] NOT NULL,
	@LastUpdatedBy  ,
    @DOS_Yr ,
	@Op_Mkt ,
    @H_Plan  ,
	@Mkt_Specific ,
	@P4Q ,
	@Living_Well ,
	@Mbr_Dcsd ,
	CASE WHEN @Term_Date = ''
	THEN NULL
	ELSE CONVERT(DATE,@Term_Date)
	END,
	@POD ,
	@PCP_Name ,
	@Mbr_ID  ,
	@Mbr_Name ,
	CASE WHEN @Mbr_Dob = ''
	THEN NULL
	ELSE CONVERT(DATE,@Mbr_Dob)
	END,
	@OPP_SCORE ,
	@BMI ,
	@BCS ,
	@COAFS ,
	@COAMR ,
	@COAPA ,
	@COLO ,
	@DRE ,
	@A1c ,
	@NEPH ,
	@CBP ,
	@MRP ,
	@PCR ,
	@OSTEO ,
	@DMARD ,
	@ODB ,
	@ACEARB ,
	@STAT ,
	@SUPD ,
	@SPC ,
	@Mbr_Phn ,
    @PCP_ID ,
	@PCP_NPI ,
	@PCP_Phn,
	CASE WHEN @Last_Screening_DOS = ''
	THEN NULL
	ELSE CONVERT(DATE, @Last_Screening_DOS)
	END,
	@Provider_Name ,
	@RISK_SCORE ,
	@AttrPCPID ,
	@AttrPCPName ,
	@AttrPOD ,
	@CM_Flag  ,
	@RiskScoreGroup ,
	@OPPScoreGroup 

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


