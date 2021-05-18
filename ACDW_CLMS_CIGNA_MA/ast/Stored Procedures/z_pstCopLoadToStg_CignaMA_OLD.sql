

CREATE PROCEDURE [ast].[z_pstCopLoadToStg_CignaMA_OLD] (@DataDate DATE, @ClientID INT)  
AS 
	BEGIN
	BEGIN TRY
	BEGIN TRAN



				
						DECLARE @AuditId INT;    
						DECLARE @JobStatus tinyInt = 1    
						DECLARE @JobType SmallInt = 9	  
						DECLARE @ClientKey INT	 = @ClientID; 
						DECLARE @JobName VARCHAR(100) = 'Load_CignaMA_ast';
						DECLARE @ActionStart DATETIME2 = GETDATE();
						DECLARE @SrcName VARCHAR(100) = 'adi.[CignaMACareOpps]'
						DECLARE @DestName VARCHAR(100) = 'ACECEREDW.[ast].[QM_ResultByMember_History]'
						DECLARE @ErrorName VARCHAR(100) = 'NA';
						DECLARE @InpCnt INT = -1;
						DECLARE @OutCnt INT = -1;
						DECLARE @ErrCnt INT = -1;
	SELECT				@InpCnt = COUNT(a.careopsCignaMaKey)    
	FROM				adi.CignaMACareOpps  a
	WHERE				DataDate = @DataDate  
	
	SELECT				@InpCnt, @DataDate
	
	
	EXEC				amd.sp_AceEtlAudit_Open 
						@AuditID = @AuditID OUTPUT
						, @AuditStatus = @JobStatus
						, @JobType = @JobType
						, @ClientKey = @ClientKey
						, @JobName = @JobName
						, @ActionStartTime = @ActionStart
						, @InputSourceName = @SrcName
						, @DestinationName = @DestName
						, @ErrorName = @ErrorName
						;
						
	CREATE TABLE		#OutputTbl (ID INT NOT NULL );

	IF OBJECT_ID('tempdb..#CignaMACareOpps') IS NOT NULL DROP TABLE #CignaMACareOpps

	CREATE TABLE		#CignaMACareOpps  ([pstQM_ResultByMbr_HistoryKey] [int] IDENTITY(1,1) NOT NULL,[astRowStatus] [varchar](20) DEFAULT'P' NOT NULL,
								[srcFileName] [varchar](150) NULL,
								[adiTableName] [varchar](100) NOT NULL,	[adiKey] [int] NOT NULL,[LoadDate] [date] NOT NULL,	
								[CreateDate] [datetime] NOT NULL,
								[CreateBy] [varchar](50) NOT NULL,[ClientKey] [int] NOT NULL,[ClientMemberKey] [varchar](50) NOT NULL
								,Category [Varchar] (50),[MemberStatus][Varchar] (50) 
								,[QmMsrId] [varchar](20) NOT NULL,[QmCntCat] [varchar](10) NOT NULL,[QMDate] [date] NULL)
	BEGIN
	INSERT INTO			#CignaMACareOpps([astRowStatus], [srcFileName], [adiTableName], [adiKey], [LoadDate], [CreateDate]
								, [CreateBy],[ClientKey], [ClientMemberKey],[Category],[MemberStatus], [QmMsrId], [QmCntCat], [QMDate])
	
	
	SELECT				'P' astRowStatus,up.SrcFileName,'[adi].[CignaMACareOpps]' AdiTable,careopsCignaMaKey
						,GETDATE()LoadDate,up.CreatedDate,SUSER_NAME()[CreateBy]
						,(SELECT ClientKey FROM lst.list_client WHERE ClientShortName = 'Cigna_MA') ClientKey
						,Mbr_ID,Measures,MeasureCategory,QM AS QmMsrId,'DEN' QmCntCat,DataDate
	FROM				(
	SELECT				DISTINCT  [careopsCignaMaKey],[SrcFileName], [DataDate], [CreatedDate], [CreatedBy], REPLACE(Mbr_ID,'*','')[Mbr_ID], [BMI]
						, [BCS], [COAFS], [COAMR], [COAPA], [COLO], [DRE], [A1c], [NEPH], [CBP], [MRP], [PCR]
						, [OSTEO], [DMARD], [ODB], [ACEARB], [STAT], [SUPD], [SPC]
	FROM				[adi].[CignaMACareOpps] 
	WHERE				DataDate = @DataDate -- '2020-07-14' -- 
						) col
	UNPIVOT
						( MeasureCategory FOR Measures IN ([BMI]
						, [BCS], [COAFS], [COAMR], [COAPA], [COLO], [DRE], [A1c], [NEPH], [CBP], [MRP], [PCR]
						, [OSTEO], [DMARD], [ODB], [ACEARB], [STAT], [SUPD], [SPC])
						) up
	JOIN				ACECAREDW.dbo.vw_ActiveMembers vw
	ON					REPLACE(UP.Mbr_ID,'*','') = vw.CLIENT_SUBSCRIBER_ID
	
	JOIN				(	Select QM,QM_DESC
							FROM lst.LIST_QM_Mapping
							WHERE QM LIKE '%Cigna%'
						)   lst
	ON					lst.QM_DESC = Measures
	WHERE				MeasureCategory <> ''

	END
	
	--Step 2 Create for NUM and COP

	BEGIN

	INSERT INTO			#CignaMACareOpps([astRowStatus], [srcFileName], [adiTableName], [adiKey], [LoadDate], [CreateDate]
						, [CreateBy],[ClientKey], [ClientMemberKey],[Category],[MemberStatus], [QmMsrId], [QmCntCat], [QMDate])
	
	SELECT				'P' ,SrcFileName,'[adi].[CignaMACareOpps]', AdiKey
						,GETDATE()LoadDate,[CreateDate],SUSER_NAME()[CreateBy]
						,(SELECT ClientKey FROM lst.list_client WHERE ClientShortName = 'Cigna_MA') ClientKey
						,[ClientMemberKey],[Category],[MemberStatus],[QmMsrId]
						,CASE WHEN MemberStatus = 'O' THEN 'COP'
							WHEN MemberStatus = 'P' THEN 'NUM'
							END QmCntCat
						,[QMDate]
	FROM				#CignaMACareOpps
	WHERE				adiTableName = '[adi].[CignaMACareOpps]'

	END
		
	--Step 3 -Insert into staging

	BEGIN

	INSERT INTO			[ACECAREDW].[ast].[QM_ResultByMember_History]([astRowStatus], [srcFileName], [adiTableName], [adiKey], [LoadDate], [CreateDate]
								, [CreateBy],[ClientKey], [ClientMemberKey],[QmMsrId], [QmCntCat], [QMDate])
	OUTPUT				inserted.pstQM_ResultByMbr_HistoryKey INTO #OutputTbl(ID)
	
	SELECT				'Exported',[srcFileName], [adiTableName], [adiKey], [LoadDate], [CreateDate]
						,[CreateBy],[ClientKey], [ClientMemberKey],[QmMsrId], [QmCntCat], [QMDate]
	FROM				#CignaMACareOpps
	
	END
	


	SELECT				@OutCnt = COUNT(*) FROM #OutputTbl;
	SET					@ActionStart  = GETDATE();
	SET					@JobStatus =2  
	    				
	EXEC				amd.sp_AceEtlAudit_Close 
						@AuditId = @AuditID
						, @ActionStopTime = @ActionStart
						, @SourceCount = @InpCnt		  
						, @DestinationCount = @OutCnt
						, @ErrorCount = @ErrCnt
						, @JobStatus = @JobStatus

	COMMIT
	END TRY

	BEGIN CATCH
	EXECUTE [dbo].[usp_QM_Error_handler]
	END CATCH

	END



	