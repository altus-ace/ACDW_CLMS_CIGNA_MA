CREATE TABLE [adi].[Claims_DiagCodes] (
    [ClaimsDiagCodesKey]   INT           IDENTITY (1, 1) NOT NULL,
    [SrcFileName]          VARCHAR (100) NOT NULL,
    [LoadDate]             DATE          NOT NULL,
    [DataDate]             DATE          NOT NULL,
    [CreatedDate]          DATETIME      CONSTRAINT [DF_adiClaimsDiagCodes_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]            VARCHAR (50)  CONSTRAINT [DF_adiClaimsDiagCodes_CreatedBy] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]      DATETIME      CONSTRAINT [DF_adiClaimsDiagCodes_LastUpdatedDate] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]        VARCHAR (50)  CONSTRAINT [DF_adiClaimsDiagCodes_LastUpdatedBy] DEFAULT (suser_sname()) NOT NULL,
    [ClaimID]              VARCHAR (50)  NULL,
    [DiagnosisCode]        VARCHAR (30)  NULL,
    [DiagnosisTypeCode]    CHAR (1)      NULL,
    [DiagnosisCodeVersion] CHAR (2)      NULL,
    [DiagnosisDesc]        VARCHAR (255) NULL,
    [Sequence]             CHAR (2)      NULL,
    [SourceDesc]           VARCHAR (350) NULL
);


GO


CREATE TRIGGER [adi].AU_Claims_DiagCodes
ON [adi].Claims_DiagCodes
AFTER UPDATE 
AS
   UPDATE adi.Claims_DiagCodes
   SET [LastUpdatedDate] = SYSDATETIME()
    ,[LastUpdatedBy] = SYSTEM_USER	
   FROM Inserted i
   WHERE adi.Claims_DiagCodes.ClaimsDiagCodesKey = i.ClaimsDiagCodesKey
   ;
