CREATE TABLE [adi].[MedClaims_Details] (
    [MedClaims_DetailsKey]  INT           IDENTITY (1, 1) NOT NULL,
    [SrcFileName]           VARCHAR (100) NOT NULL,
    [LoadDate]              DATE          NOT NULL,
    [DataDate]              DATE          NOT NULL,
    [CreatedDate]           DATETIME      CONSTRAINT [DF_adiMedClaims_Details_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]             VARCHAR (50)  CONSTRAINT [DF_adiMedClaims_Details_CreatedBy] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]       DATETIME      CONSTRAINT [DF_adiMedClaims_Details_LastUpdatedDate] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]         VARCHAR (50)  CONSTRAINT [DF_adiMedClaims_Details_LastUpdatedBy] DEFAULT (suser_sname()) NOT NULL,
    [ClaimID]               VARCHAR (50)  NULL,
    [ClaimLineID]           VARCHAR (5)   NULL,
    [PlaceOfService]        VARCHAR (50)  NULL,
    [SubmittedUnits]        INT           NULL,
    [WithHoldAmt]           MONEY         NULL,
    [EligibleFeeAmt]        MONEY         NULL,
    [BeginServicedate]      DATE          NULL,
    [EndServiceDate]        DATE          NULL,
    [PaidDate]              DATE          NULL,
    [CapitatedLineService]  CHAR (1)      NULL,
    [RevenueCode]           VARCHAR (50)  NULL,
    [ProcedureCode]         VARCHAR (15)  NULL,
    [ProcedureCodeType]     CHAR (1)      NULL,
    [ProcedureCodeVersion]  CHAR (1)      NULL,
    [ProcedureModifier1]    CHAR (50)     NULL,
    [ProcedureModifier2]    CHAR (50)     NULL,
    [ProcedureModifier3]    CHAR (50)     NULL,
    [ProcedureModifier4]    CHAR (50)     NULL,
    [SubmittedAmount]       MONEY         NULL,
    [AllowedAmount]         MONEY         NULL,
    [PaidAmount]            MONEY         NULL,
    [DeductableAmount]      MONEY         NULL,
    [CopayAmount]           MONEY         NULL,
    [CoinsuranceAmount]     MONEY         NULL,
    [DeniedAmount]          MONEY         NULL,
    [Vendor]                VARCHAR (80)  NULL,
    [ClaimLineStatus]       CHAR (15)     NULL,
    [HCPCSAPCode]           VARCHAR (5)   NULL,
    [PaymentAPCode]         VARCHAR (5)   NULL,
    [FracUnits]             VARCHAR (10)  NULL,
    [ProviderTaxonomyCode]  VARCHAR (50)  NULL,
    [ProviderSpecialtyCode] VARCHAR (50)  NULL,
    [SourceDesc]            VARCHAR (350) NULL
);


GO


CREATE TRIGGER [adi].AU_MedClaims_Details
ON [adi].MedClaims_Details
AFTER UPDATE 
AS
   UPDATE adi.MedClaims_Details
   SET [LastUpdatedDate] = SYSDATETIME()
    ,[LastUpdatedBy] = SYSTEM_USER	
   FROM Inserted i
   WHERE adi.MedClaims_Details.MedClaims_DetailsKey = i.MedClaims_DetailsKey
   ;
