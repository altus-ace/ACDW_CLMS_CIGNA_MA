
	
	CREATE	PROCEDURE [ast].[UpdateAdiLineageCOP]

	AS

	BEGIN

	UPDATE		adi.CignaMA_ACECustomerSummary 
	SET			CopLoadStatus = 1 --SELECT		*
	WHERE		CopLoadStatus = 0

	END