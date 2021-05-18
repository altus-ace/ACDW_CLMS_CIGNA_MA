
	CREATE PROCEDURE [adw].[pstCopExportStagingToAdw_CignaMA] (@QMDate DATE, @ClientID INT)
	AS
	 
SET NOCOUNT ON
	BEGIN
	
	BEGIN TRY
	BEGIN TRAN  

						DECLARE @AuditId INT;    
						DECLARE @JobStatus tinyInt = 1    
						DECLARE @JobType SmallInt = 9	  
						DECLARE @ClientKey INT	 = @ClientID; 
						DECLARE @JobName VARCHAR(100) = 'CignaMA_COP_Load_adw';
						DECLARE @ActionStart DATETIME2 = GETDATE();
						DECLARE @SrcName VARCHAR(100) = 'ACECAREDW.ast.[QM_ResultByMember_History]'
						DECLARE @DestName VARCHAR(100) = 'ACECAREDW.[adw].[QM_ResultByMember_History]'
						DECLARE @ErrorName VARCHAR(100) = 'NA';
						DECLARE @InpCnt INT = -1;
						DECLARE @OutCnt INT = -1;
						DECLARE @ErrCnt INT = -1;
	SELECT				@InpCnt = COUNT(a.pstQM_ResultByMbr_HistoryKey)    
	FROM				ACECAREDW.ast.QM_ResultByMember_History  a
	WHERE				QMDate = @QMDate 
	AND					ClientKey = @ClientKey 
	
	SELECT				@InpCnt, @QMDate
	
	
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

	INSERT	INTO		[ACECAREDW].[adw].[QM_ResultByMember_History]
						(ClientKey, ClientMemberKey,QmMsrId,QmCntCat,QMDate,CreateDate,CreateBy,AdiKey)
	OUTPUT				inserted.QM_ResultByMbr_HistoryKey INTO #OutputTbl(ID)
	SELECT				ClientKey
						, ClientMemberKey
						,QmMsrId
						,QmCntCat
						,QMDate
						,CreateDate
						,CreateBy
						,AdiKey
	FROM				[ACECAREDW].[ast].[QM_ResultByMember_History]  
	WHERE				ClientKey = @ClientKey 
	AND					QMDate = @QMDate

	
	
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

	
