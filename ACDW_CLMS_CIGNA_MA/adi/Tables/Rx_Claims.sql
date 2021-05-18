CREATE TABLE [adi].[Rx_Claims] (
    [RxClaimsKey]             INT           IDENTITY (1, 1) NOT NULL,
    [SrcFileName]             VARCHAR (100) NOT NULL,
    [LoadDate]                DATE          NOT NULL,
    [DataDate]                DATE          NOT NULL,
    [CreatedDate]             DATETIME      CONSTRAINT [DF_adiRxClaims_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]               VARCHAR (50)  CONSTRAINT [DF_adiRxClaims_CreatedBy] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]         DATETIME      CONSTRAINT [DF_adiRxClaims_LastUpdatedDate] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]           VARCHAR (50)  CONSTRAINT [DF_adiRxClaims_LastUpdatedBy] DEFAULT (suser_sname()) NOT NULL,
    [ClaimID]                 VARCHAR (15)  NULL,
    [PrescribingProviderNPI]  VARCHAR (15)  NULL,
    [PharmacyNPI]             VARCHAR (10)  NULL,
    [PrescriptionWrittenDate] DATE          NULL,
    [FillDate]                DATE          NULL,
    [PrescriptionID]          VARCHAR (12)  NULL,
    [NDC]                     VARCHAR (20)  NULL,
    [TherapeuticClass]        CHAR (3)      NULL,
    [DAW]                     CHAR (1)      NULL,
    [FilledRefills]           VARCHAR (2)   NULL,
    [DaysSupply]              INT           NULL,
    [QuantityDispensed]       VARCHAR (9)   NULL,
    [PharmacyChainID]         VARCHAR (10)  NULL,
    [ClaimSequenceNbr]        CHAR (3)      NULL,
    [ClaimStatus]             CHAR (1)      NULL,
    [ContractNumber]          VARCHAR (15)  NULL,
    [PlanBenefitPackage]      VARCHAR (3)   NULL,
    [GPINumber]               VARCHAR (14)  NULL,
    [BrandGenericCode]        CHAR (1)      NULL,
    [SubmittedAmount]         MONEY         NULL,
    [AllowedAmount]           MONEY         NULL,
    [PaidAmount]              MONEY         NULL,
    [DrugCovStsCode]          CHAR (1)      NULL,
    [ProcessDateThru]         DATE          NULL,
    [MemberID]                VARCHAR (20)  NULL,
    [PaidDate]                DATE          NULL,
    [ClaimType_IPRE]          CHAR (2)      NULL,
    [AllowedRefills]          INT           NULL,
    [SupplyFlag]              CHAR (1)      NULL,
    [SourceDesc]              VARCHAR (60)  NULL
);


GO


CREATE TRIGGER [adi].AU_RX_Claims
ON [adi].Rx_Claims
AFTER UPDATE 
AS
   UPDATE adi.Rx_Claims
   SET [LastUpdatedDate] = SYSDATETIME()
    ,[LastUpdatedBy] = SYSTEM_USER	
   FROM Inserted i
   WHERE adi.Rx_Claims.RxClaimsKey = i.RxClaimsKey
   ;
