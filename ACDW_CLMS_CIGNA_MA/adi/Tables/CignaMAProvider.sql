CREATE TABLE [adi].[CignaMAProvider] (
    [CignaMAProviderKey]   INT           IDENTITY (1, 1) NOT NULL,
    [SrcFileName]          VARCHAR (100) NOT NULL,
    [LoadDate]             DATE          NOT NULL,
    [DataDate]             DATE          NOT NULL,
    [CreatedDate]          DATETIME      CONSTRAINT [DF_adiCignaMaProvider_Details_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]            VARCHAR (50)  CONSTRAINT [DF_adiCignaMaProvider_Details_CreatedBy] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]      DATETIME      CONSTRAINT [DF_adiCignaMaProvider_Details_LastUpdatedDate] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]        VARCHAR (50)  CONSTRAINT [DF_adiCignaMaProvider_Details_LastUpdatedBy] DEFAULT (suser_sname()) NOT NULL,
    [ProviderID]           VARCHAR (20)  NULL,
    [SpecialtyCode]        VARCHAR (95)  NULL,
    [TaxID]                VARCHAR (25)  NULL,
    [NPI]                  VARCHAR (10)  NULL,
    [DEANumber]            VARCHAR (10)  NULL,
    [UPIN]                 VARCHAR (20)  NULL,
    [AddressLine1]         VARCHAR (60)  NULL,
    [AddressLine2]         VARCHAR (60)  NULL,
    [City]                 VARCHAR (30)  NULL,
    [State]                CHAR (2)      NULL,
    [ZIPCode]              VARCHAR (9)   NULL,
    [Phone]                VARCHAR (20)  NULL,
    [Prescriber]           VARCHAR (15)  NULL,
    [AddressTypeCode]      VARCHAR (2)   NULL,
    [NewPatientFlag]       CHAR (1)      NULL,
    [LastName]             VARCHAR (60)  NULL,
    [FirstName]            VARCHAR (40)  NULL,
    [PCPFlag]              CHAR (1)      NULL,
    [SpecialtyCodeDesc]    VARCHAR (100) NULL,
    [ProvCategory]         VARCHAR (15)  NULL,
    [P4QFlag]              CHAR (1)      NULL,
    [P4QGroup]             VARCHAR (20)  NULL,
    [P4QStartDateKey]      DATE          NULL,
    [P4QEndDateKey]        DATE          NULL,
    [P4Q2Flag]             CHAR (1)      NULL,
    [P4Q2Group]            VARCHAR (20)  NULL,
    [P4Q2StartDateKey]     DATE          NULL,
    [P4Q2EndDateKey]       DATE          NULL,
    [CHSProviderSpecialty] VARCHAR (15)  NULL
);


GO


CREATE TRIGGER [adi].AU_CignaMAProvider
ON [adi].CignaMAProvider
AFTER UPDATE 
AS
   UPDATE adi.CignaMAProvider
   SET [LastUpdatedDate] = SYSDATETIME()
    ,[LastUpdatedBy] = SYSTEM_USER	
   FROM Inserted i
   WHERE adi.CignaMAProvider.CignaMAProviderKey = i.CignaMAProviderKey
   ;
