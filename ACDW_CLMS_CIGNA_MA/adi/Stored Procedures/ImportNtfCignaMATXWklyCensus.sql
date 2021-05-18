-- =============================================
-- Author:		Bing Yu
-- Create date: 09/08/2020
-- Description:	Insert Cigna MA AWV to DB
-- ============================================
CREATE PROCEDURE [adi].[ImportNtfCignaMATXWklyCensus]
	
	@SrcFileName [varchar](100),
	--[LoadDate] [date] NOT NULL,
	@DataDate varchar(10) NULL,
	--[CreatedDate] [datetime] NOT NULL,
	@CreatedBy [varchar](50) ,
	--@LastUpdatedDate] [datetime] NOT NULL,
	@LastUpdatedBy [varchar](50) ,
	@member_id [varchar](50),
	@Member_Name [varchar](50),
	@admission_date varchar(20),
	@authorization_number [varchar](50),
	@facility_name [varchar](50),
	@facility_id [varchar](50),
	@diagnosis_desc [varchar](500),
	@prov_first [varchar](50) ,
	@prov_last [varchar](50),
	@admission_type_desc [varchar](500),
	@actual_discharge_date varchar(20),
	@ccmspod [varchar](50),
	@authorized_admission_date varchar(20),
	@event_mgmt_status_desc varchar (100),
	@actual_los [varchar](10) ,
	@diagnosis_code [varchar](50) ,
	@diag_1st_3 [varchar](50) ,
	@provider_first_name [varchar](50),
	@managing_provider [varchar](50),
	@provider_last_name [varchar](50),
	@admission_reason [varchar](50),
	@benefit_plan [varchar](50),
	@attending_provider [varchar](50) ,
	@ezcapid [varchar](50) ,
	@los [varchar](50) ,
	@pcp_name [varchar](50) ,
	@ezpcpfirst [varchar](50) ,
	@ezpcplast [varchar](50),
	@ezpcpid [varchar](50) ,
	@obscnt [varchar](50) ,
	@ltaccnt [varchar](50),
	@ezpod [varchar](50) ,
	@mkt [varchar](50) ,
	@disease_state [varchar](50) ,
	@opt [varchar](50) ,
	@program [varchar](50) ,
	@group [varchar](50) ,
	@bed_type [varchar](50) ,
	@data_date VARCHAR(20),
	@source [varchar](50) ,
	@link_date vARCHAR(20),
	@linkdate_dt varchar(20),
	@ezpod_abbr [varchar](50),
	@event_status [varchar](50) ,
	@birth varchar(20),
	@Age_at_Admit [varchar](10) ,
	@Market_member_months [varchar](10) ,
	@request_date varchar(20),
	@readmit1_auth [varchar](50) ,
	@readmit1_diag [varchar](50) ,
	@readmit1_diagdesc [varchar](500) ,
	@readmit2_auth [varchar](50),
	@readmit2_diag [varchar](50) ,
	@readmit2_diagdesc [varchar](500) ,
	@readmit3_auth [varchar](50) ,
	@readmit3_diag [varchar](50) ,
	@readmit3_diagdesc [varchar](500) ,
	@pended [varchar](50) NULL,
	@dx_category [varchar](50),
	@MDC_Code [varchar](10) ,
	@InstPaid [varchar](10) ,
	@ProfPaid [varchar](10),
	@discharge_status [varchar](10),
	@FacilityParFlag [varchar](10),
	@Admission_Procedure1 [varchar](50) ,
	@Admission_Procedure2 [varchar](50) ,
	@Admission_Procedure3 [varchar](50) ,
	@Admission_Procedure4 [varchar](50),
	@AdmitNotificationDays varchar(5) ,
	@RegionCode [varchar](50) ,
	@Hcode [varchar](50),
	@PBP [varchar](50) 
            
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


    IF(@member_id != '' )	
	BEGIN
    INSERT INTO [adi].[NtfCignaMATXWklyCensus]
    (
    [SrcFileName] ,
	[LoadDate] ,
	[DataDate] ,
	[CreatedDate] ,
	[CreatedBy] ,
	[LastUpdatedDate] ,
	[LastUpdatedBy] ,
	[member_id] ,
	[Member_Name] ,
	[admission_date] ,
	[authorization_number] ,
	[facility_name] ,
	[facility_id] ,
	[diagnosis_desc] ,
	[prov_first] ,
	[prov_last] ,
	[admission_type_desc] ,
	[actual_discharge_date] ,
	[ccmspod] ,
	[authorized_admission_date] ,
	[event_mgmt_status_desc] ,
	[actual_los] ,
	[diagnosis_code] ,
	[diag_1st_3] ,
	[provider_first_name] ,
	[managing_provider] ,
	[provider_last_name] ,
	[admission_reason] ,
	[benefit_plan] ,
	[attending_provider] ,
	[ezcapid] ,
	[los] ,
	[pcp_name] ,
	[ezpcpfirst] ,
	[ezpcplast] ,
	[ezpcpid] ,
	[obscnt] ,
	[ltaccnt] ,
	[ezpod] ,
	[mkt] ,
	[disease_state] ,
	[opt] ,
	[program] ,
	[group] ,
	[bed_type] ,
	[data_date] ,
	[source] ,
	[link_date] ,
	[linkdate_dt] ,
	[ezpod_abbr] ,
	[event_status] ,
	[birth] ,
	[Age_at_Admit] ,
	[Market_member_months] ,
	[request_date] ,
	[readmit1_auth] ,
	[readmit1_diag] ,
	[readmit1_diagdesc] ,
	[readmit2_auth] ,
	[readmit2_diag] ,
	[readmit2_diagdesc],
	[readmit3_auth] ,
	[readmit3_diag] ,
	[readmit3_diagdesc] ,
	[pended] ,
	[dx_category] ,
	[MDC_Code] ,
	[InstPaid] ,
	[ProfPaid] ,
	[discharge_status] ,
	[FacilityParFlag] ,
	[Admission_Procedure1] ,
	[Admission_Procedure2] ,
	[Admission_Procedure3] ,
	[Admission_Procedure4] ,
	[AdmitNotificationDays],
	[RegionCode] ,
	[Hcode] ,
	[PBP] 

	)
		
 VALUES  (
  @SrcFileName ,
  GETDATE(),
	--[LoadDate] [date] NOT NULL,
	CASE WHEN @DataDate =''
	THEN NULL
	ELSE CONVERT(DATE,@DataDate)
	END ,
	GETDATE(),
	--[CreatedDate] [datetime] NOT NULL,
	@CreatedBy ,
	GETDATE(),
	--@LastUpdatedDate] [datetime] NOT NULL,
	@LastUpdatedBy  ,
	@member_id ,
	@Member_Name ,
	--CASE WHEN @admission_date =''
	--THEN NULL
	--ELSE CONVERT(DATE,@admission_date)
	--END ,
	@admission_date,
	@authorization_number ,
	@facility_name ,
	@facility_id,
	@diagnosis_desc ,
	@prov_first  ,
	@prov_last ,
	@admission_type_desc,
	--CASE WHEN @actual_discharge_date =''
	--THEN NULL
	--ELSE CONVERT(DATE,@actual_discharge_date)
	--END ,
    @actual_discharge_date,
	@ccmspod ,
	--CASE WHEN @authorized_admission_date =''
	--THEN NULL
	--ELSE CONVERT(DATE, @authorized_admission_date)
	--END ,
	@authorized_admission_date,
	@event_mgmt_status_desc ,
	@actual_los ,
	@diagnosis_code ,
	@diag_1st_3 ,
	@provider_first_name ,
	@managing_provider ,
	@provider_last_name ,
	@admission_reason ,
	@benefit_plan ,
	@attending_provider  ,
	@ezcapid  ,
	@los  ,
	@pcp_name  ,
	@ezpcpfirst  ,
	@ezpcplast ,
	@ezpcpid  ,
	@obscnt  ,
	@ltaccnt ,
	@ezpod  ,
	@mkt  ,
	@disease_state  ,
	@opt  ,
	@program  ,
	@group  ,
	@bed_type  ,
	CASE WHEN @data_date =''
	THEN NULL
	ELSE CONVERT(datetime, @data_date)
	END ,
	@source  ,
	--CASE WHEN 	@link_date =''
	--THEN NULL
	--ELSE CONVERT(DATE, 	@link_date)
	--END ,
	@link_date,
	--CASE WHEN @linkdate_dt  =''
	--THEN NULL
	--ELSE CONVERT(DATE, @linkdate_dt )
	--END ,
@linkdate_dt,
	@ezpod_abbr ,
	@event_status  ,
	--CASE WHEN @birth   =''
	--THEN NULL
	--ELSE CONVERT(DATE, @birth  )
	--END ,
	@birth,
	@Age_at_Admit  ,
	@Market_member_months  ,
	--CASE WHEN @request_date    =''
	--THEN NULL
	--ELSE CO,NVERT(DATE, @request_date )
	--END ,
	@request_date,
	@readmit1_auth  ,
	@readmit1_diag  ,
	@readmit1_diagdesc  ,
	@readmit2_auth ,
	@readmit2_diag  ,
	@readmit2_diagdesc  ,
	@readmit3_auth  ,
	@readmit3_diag  ,
	@readmit3_diagdesc  ,
	@pended  ,
	@dx_category ,
	@MDC_Code  ,
	@InstPaid ,
	@ProfPaid ,
	@discharge_status ,
	@FacilityParFlag ,
	@Admission_Procedure1  ,
	@Admission_Procedure2  ,
	@Admission_Procedure3  ,
	@Admission_Procedure4,
	CASE WHEN @AdmitNotificationDays     =''
	THEN NULL
	ELSE CONVERT(smallint, @AdmitNotificationDays  )
	END ,
	 
	@RegionCode  ,
	@Hcode ,
	@PBP
)

END


    
END


