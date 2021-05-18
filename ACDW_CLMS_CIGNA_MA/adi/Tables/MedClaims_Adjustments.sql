CREATE TABLE [adi].[MedClaims_Adjustments] (
    [MedClaims_AdjustmentsKey] INT           IDENTITY (1, 1) NOT NULL,
    [SrcFileName]              VARCHAR (100) NOT NULL,
    [LoadDate]                 DATE          NOT NULL,
    [DataDate]                 DATE          NOT NULL,
    [CreatedDate]              DATETIME      CONSTRAINT [DF_adiMedClaims_Adjustments_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]                VARCHAR (50)  CONSTRAINT [DF_adiMedClaims_Adjustments_CreatedBy] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]          DATETIME      CONSTRAINT [DF_adiMedClaims_Adjustments_LastUpdatedDate] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]            VARCHAR (50)  CONSTRAINT [DF_adiMedClaims_Adjustments_LastUpdatedBy] DEFAULT (suser_sname()) NOT NULL,
    [ClaimID]                  VARCHAR (50)  NULL,
    [ClaimLineID]              VARCHAR (5)   NULL,
    [AdjustmentCode]           VARCHAR (15)  NULL,
    [AdjustmentCodeDesc]       VARCHAR (150) NULL,
    [AdjustmentSequence]       INT           NULL,
    [AdjustmentStatus]         VARCHAR (10)  NULL,
    [SourceDesc]               VARCHAR (350) NULL
);


GO


CREATE TRIGGER [adi].AU_MedClaims_Adjustments
ON [adi].MedClaims_Adjustments
AFTER UPDATE 
AS
   UPDATE adi.MedClaims_Adjustments
   SET [LastUpdatedDate] = SYSDATETIME()
    ,[LastUpdatedBy] = SYSTEM_USER	
   FROM Inserted i
   WHERE adi.MedClaims_Adjustments.MedClaims_AdjustmentsKey = i.MedClaims_AdjustmentsKey
   ;
