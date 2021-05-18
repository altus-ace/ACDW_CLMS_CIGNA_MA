CREATE TABLE [adi].[MedClaims_Headers] (
    [MedClaims_HeadersKey] INT           IDENTITY (1, 1) NOT NULL,
    [SrcFileName]          VARCHAR (100) NOT NULL,
    [LoadDate]             DATE          NOT NULL,
    [DataDate]             DATE          NOT NULL,
    [CreatedDate]          DATETIME      CONSTRAINT [DF_adiMedClaims_Headers_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]            VARCHAR (50)  CONSTRAINT [DF_adiMedClaims_Headers_CreatedBy] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]      DATETIME      CONSTRAINT [DF_adiMedClaims_Headers_LastUpdatedDate] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]        VARCHAR (50)  CONSTRAINT [DF_adiMedClaims_Headers_LastUpdatedBy] DEFAULT (suser_sname()) NOT NULL,
    [ClaimID]              VARCHAR (50)  NULL,
    [MemberID]             VARCHAR (16)  NULL,
    [RenderingProviderID]  VARCHAR (20)  NULL,
    [ReferringProviderID]  VARCHAR (25)  NULL,
    [AttendingProvider]    VARCHAR (25)  NULL,
    [ClaimVersion]         VARCHAR (1)   NULL,
    [OriginalClaim]        VARCHAR (50)  NULL,
    [TypeOfBill]           VARCHAR (3)   NULL,
    [DRGCode]              VARCHAR (6)   NULL,
    [StatementFromDate]    DATE          NULL,
    [StatementThroughDate] DATE          NULL,
    [AdmitDate]            DATE          NULL,
    [ReceivedDate]         DATE          NULL,
    [ProcessedDate]        DATE          NULL,
    [PatientStatus]        VARCHAR (5)   NULL,
    [BenefitPlan]          VARCHAR (15)  NULL,
    [LOBCode]              VARCHAR (15)  NULL,
    [LOBDesc]              VARCHAR (60)  NULL,
    [DischargeDate]        DATE          NULL,
    [PaidDate]             DATE          NULL,
    [ClaimStatus]          VARCHAR (10)  NULL,
    [ClaimType_IPRE]       VARCHAR (2)   NULL,
    [FormTypeCode]         CHAR (1)      NULL,
    [DaysDenied]           CHAR (1)      NULL,
    [SourceDesc]           VARCHAR (350) NULL,
    [BaseClaimID]          VARCHAR (50)  NULL
);


GO


CREATE TRIGGER [adi].AU_MedClaims_Headers
ON [adi].MedClaims_Headers
AFTER UPDATE 
AS
   UPDATE adi.MedClaims_Headers
   SET [LastUpdatedDate] = SYSDATETIME()
    ,[LastUpdatedBy] = SYSTEM_USER	
   FROM Inserted i
   WHERE adi.MedClaims_Headers.MedClaims_HeadersKey = i.MedClaims_HeadersKey
   ;
