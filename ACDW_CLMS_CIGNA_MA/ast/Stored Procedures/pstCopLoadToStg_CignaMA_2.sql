

CREATE PROCEDURE [ast].[pstCopLoadToStg_CignaMA_2] (@DataDate DATE, @ClientID INT, @QMDATE DATE)  
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
						DECLARE @SrcName VARCHAR(100) = '[adi].[CignaMA_ACECustomerSummary]'
						DECLARE @DestName VARCHAR(100) = 'ACECEREDW.[ast].[QM_ResultByMember_History]'
						DECLARE @ErrorName VARCHAR(100) = 'NA';
						DECLARE @InpCnt INT = -1;
						DECLARE @OutCnt INT = -1;
						DECLARE @ErrCnt INT = -1;
	SELECT				@InpCnt = COUNT(a.ACECustomerSummaryKey)    
	FROM				[adi].[CignaMA_ACECustomerSummary]  a
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
	
	
	SELECT				'P' astRowStatus,SrcFileName,'[adi].[CignaMA_ACECustomerSummary]' AdiTable,ACECustomerSummaryKey
						,GETDATE()LoadDate,CreatedDate,SUSER_NAME()[CreateBy]
						,(SELECT ClientKey FROM lst.list_client WHERE ClientShortName = 'Cigna_MA') ClientKey
						,Mbr_ID,Meas_Abbv,Compliant,QM AS QmMsrId,'DEN' QmCntCat,@QMDATE
	FROM	(
				
				SELECT			''rws,SrcFileName,'[adi].[CignaMA_ACECustomerSummary]' AdiTable, ACECustomerSummaryKey, LoadDate,CreatedDate,CreatedBy
								, Mbr_ID , Meas_Abbv,Compliant,QM--,Meas_Abbv_Transformed
								,DataDate 
				FROM				(
									SELECT				DISTINCT ''rws,a.SrcFileName,'[adi].[CignaMA_ACECustomerSummary]' AdiTable, ACECustomerSummaryKey
														,a.LoadDate,CreatedDate,CreatedBy
														,REPLACE(Mbr_ID,'*','') Mbr_ID , a.Meas_Abbv
														,Compliant,DataDate
														,CASE Meas_Abbv
														WHEN 'CDCDRE' THEN 'DRE'
														WHEN 'CDCNEPH' THEN 'NEPH'
														WHEN 'COAFSA' THEN 'COAFS'
														WHEN  'COL' THEN 'COLO'
														WHEN 'HBA1CCTL' THEN 'A1c'
														ELSE Meas_Abbv
														END Meas_Abbv_Transformed
									FROM				[adi].[CignaMA_ACECustomerSummary] a
									JOIN				ACECAREDW.dbo.vw_ActiveMembers vw
									ON					REPLACE(Mbr_ID,'*','') = vw.CLIENT_SUBSCRIBER_ID
									)	inn
				JOIN				(					Select QM_Desc,QM 
														FROM lst.LIST_QM_Mapping
														WHERE QM LIKE '%Cigna%'
									)   lst
				ON				lst.QM_DESC = inn.Meas_Abbv_Transformed
				WHERE			Meas_Abbv <> ''
				AND				DataDate  = @DataDate
			)src
	END
	
	--Step 2 Create for NUM and COP

	BEGIN

	INSERT INTO			#CignaMACareOpps([astRowStatus], [srcFileName], [adiTableName], [adiKey], [LoadDate], [CreateDate]
						, [CreateBy],[ClientKey], [ClientMemberKey],[Category],[MemberStatus], [QmMsrId], [QmCntCat], [QMDate])
	
	SELECT				'P' ,SrcFileName,'[adi].[CignaMA_ACECustomerSummary]', AdiKey
						,GETDATE()LoadDate,[CreateDate],SUSER_NAME()[CreateBy]
						,(SELECT ClientKey FROM lst.list_client WHERE ClientShortName = 'Cigna_MA') ClientKey
						,[ClientMemberKey],[Category],[MemberStatus],[QmMsrId]
						,CASE WHEN MemberStatus = '0' THEN 'COP'
							WHEN MemberStatus = '1' THEN 'NUM'
							END QmCntCat
						,@QMDATE
	FROM				#CignaMACareOpps
	WHERE				adiTableName = '[adi].[CignaMA_ACECustomerSummary]'

	END
		
	--Step 3 -Insert into staging

	BEGIN

	INSERT INTO			[ACECAREDW].[ast].[QM_ResultByMember_History](
						[astRowStatus]
						, [srcFileName]
						, [adiTableName]
						, [adiKey]
						, [LoadDate]
						, [CreateDate]
						, [CreateBy]
						, [ClientKey]
						, [ClientMemberKey]
						, [QmMsrId]
						, [QmCntCat]
						, [QMDate])
	OUTPUT				inserted.pstQM_ResultByMbr_HistoryKey INTO #OutputTbl(ID)
	
	SELECT				'Exported'
						,[srcFileName]
						, [adiTableName]
						, [adiKey]
						, [LoadDate]
						, [CreateDate]
						, [CreateBy]
						, [ClientKey]
						, [ClientMemberKey]
						, [QmMsrId]
						, [QmCntCat]
						, [QMDate]
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

	
	/**
	USAGE: EXECUTE [ast].[pstCopLoadToStg_CignaMA_2]'2021-04-23',12,'2021-05-15'
	*/ 