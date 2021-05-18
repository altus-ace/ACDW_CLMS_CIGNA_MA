CREATE TABLE [adi].[Claims_ProcCodes] (
    [ClaimsProcCodesKey]   INT           IDENTITY (1, 1) NOT NULL,
    [SrcFileName]          VARCHAR (100) NOT NULL,
    [LoadDate]             DATE          NOT NULL,
    [DataDate]             DATE          NOT NULL,
    [CreatedDate]          DATETIME      CONSTRAINT [DF_adiClaimsProcCodes_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]            VARCHAR (50)  CONSTRAINT [DF_adiClaimsProcCodes_CreatedBy] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]      DATETIME      CONSTRAINT [DF_adiClaimsProcCodes_LastUpdatedDate] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]        VARCHAR (50)  CONSTRAINT [DF_adiClaimsProcCodes_LastUpdatedBy] DEFAULT (suser_sname()) NOT NULL,
    [ClaimID]              VARCHAR (50)  NULL,
    [ProcedureCode]        VARCHAR (30)  NULL,
    [ProcedureCodeDesc]    VARCHAR (255) NULL,
    [ProcedureTypeCode]    CHAR (2)      NULL,
    [ProcedureCodeVersion] VARCHAR (1)   NULL,
    [Sequence]             CHAR (2)      NULL,
    [SourceDesc]           VARCHAR (350) NULL
);


GO


CREATE TRIGGER [adi].AU_Claims_ProcCodes
ON [adi].Claims_ProcCodes
AFTER UPDATE 
AS
   UPDATE adi.Claims_ProcCodes
   SET [LastUpdatedDate] = SYSDATETIME()
    ,[LastUpdatedBy] = SYSTEM_USER	
   FROM Inserted i
   WHERE adi.Claims_ProcCodes.ClaimsProcCodesKey = i.ClaimsProcCodesKey
   ;
