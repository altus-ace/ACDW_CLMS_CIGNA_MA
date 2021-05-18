CREATE TABLE [adi].[CignaMAMembership] (
    [mbrCignaMaKey]        INT           IDENTITY (1, 1) NOT NULL,
    [SrcFileName]          VARCHAR (100) NOT NULL,
    [LoadDate]             DATE          NOT NULL,
    [DataDate]             DATE          NOT NULL,
    [CreatedDate]          DATETIME      CONSTRAINT [DF_adiCignaMaMembership_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]            VARCHAR (50)  CONSTRAINT [DF_adiCignaMaMembership_CreatedBy] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]      DATETIME      CONSTRAINT [DF_adiCignaMaMembership_LastUpdatedDate] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]        VARCHAR (50)  CONSTRAINT [DF_adiCignaMaMembership_LastUpdatedBy] DEFAULT (suser_sname()) NOT NULL,
    [MemberID]             VARCHAR (50)  NULL,
    [BirthDate]            DATE          NULL,
    [Gender]               CHAR (1)      NULL,
    [FirstName]            VARCHAR (50)  NULL,
    [LastName]             VARCHAR (50)  NULL,
    [MiddleName]           VARCHAR (50)  NULL,
    [Relationship]         CHAR (1)      NULL,
    [MailingAddressLine1]  VARCHAR (60)  NULL,
    [MailingAddressLine2]  VARCHAR (60)  NULL,
    [MailingAddressLine3]  VARCHAR (40)  NULL,
    [MailingCity]          VARCHAR (30)  NULL,
    [MailingState]         CHAR (2)      NULL,
    [MailingZip]           VARCHAR (10)  NULL,
    [MailingCounty]        VARCHAR (35)  NULL,
    [LanguageDesc]         VARCHAR (350) NULL,
    [MedicareID]           VARCHAR (50)  NULL,
    [MedicaidID]           VARCHAR (25)  NULL,
    [HomePhone]            VARCHAR (20)  NULL,
    [CellPhone]            VARCHAR (20)  NULL,
    [WorkPhone]            VARCHAR (20)  NULL,
    [Email]                VARCHAR (256) NULL,
    [DateOfDeath]          DATE          NULL,
    [PhysicalAddressLine1] VARCHAR (60)  NULL,
    [PhysicalAddressLine2] VARCHAR (60)  NULL,
    [PhysicalAddressLine3] VARCHAR (40)  NULL,
    [PhysicalCity]         VARCHAR (30)  NULL,
    [PhysicalState]        CHAR (2)      NULL,
    [PhysicalZip]          VARCHAR (10)  NULL,
    [PhyscialCounty]       VARCHAR (35)  NULL,
    [SourceDesc]           VARCHAR (15)  NULL
);


GO

CREATE TRIGGER [adi].AU_CignaMAMembership
ON [adi].CignaMAMembership
AFTER UPDATE 
AS
   UPDATE adi.CignaMAMembership
   SET [LastUpdatedDate] = SYSDATETIME()
    ,[LastUpdatedBy] = SYSTEM_USER	
   FROM Inserted i
   WHERE adi.CignaMAMembership.mbrCignaMaKey = i.mbrCignaMaKey
   ;
