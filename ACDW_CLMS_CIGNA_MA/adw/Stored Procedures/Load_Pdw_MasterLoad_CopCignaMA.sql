
CREATE  PROCEDURE [adw].[Load_Pdw_MasterLoad_CopCignaMA] (@DataDate DATE, @ClientKey INT,@QMDate DATE)
AS



BEGIN


	EXEC [ast].[pstCopLoadToStg_CignaMA_2] @DataDate,@ClientKey 	 

END

BEGIN

	EXEC ast. UpdateAdiLineageCOP 
END
BEGIN

	EXEC [adw].[pstCopExportStagingToAdw_CignaMA] @QMDate,@ClientKey


END

