CREATE TABLE [adw].[DimCignaMAMemberKeys] (
    [DimCignaMAMemberKeys] INT           IDENTITY (1, 1) NOT NULL,
    [CreatedDate]          DATETIME      DEFAULT (getdate()) NULL,
    [CreatedBy]            VARCHAR (50)  DEFAULT (suser_sname()) NULL,
    [LastUpdatedDate]      DATETIME      DEFAULT (getdate()) NULL,
    [LastUpdatedBy]        VARCHAR (50)  DEFAULT (suser_sname()) NULL,
    [AdiKey]               INT           NULL,
    [SrcFileName]          VARCHAR (100) NULL,
    [LoadDate]             DATE          NULL,
    [DataDate]             DATE          NULL,
    [ClientKey]            INT           NULL,
    [ACE_ID]               NUMERIC (15)  NULL,
    [ClientMemberKey]      VARCHAR (50)  NULL,
    [MedicareID]           VARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([DimCignaMAMemberKeys] ASC)
);

