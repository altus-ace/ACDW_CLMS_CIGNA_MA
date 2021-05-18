CREATE TABLE [adi].[CignaMA_ACECustomerSummary] (
    [ACECustomerSummaryKey] INT           IDENTITY (1, 1) NOT NULL,
    [SrcFileName]           VARCHAR (100) NOT NULL,
    [LoadDate]              DATE          NOT NULL,
    [DataDate]              DATE          NOT NULL,
    [CreatedDate]           DATETIME      CONSTRAINT [DF_CignaMA_ACECustomerSummary_CreatedDate] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]             VARCHAR (50)  CONSTRAINT [DF_CignaMA_ACECustomerSummary_CreatedBy] DEFAULT (suser_sname()) NOT NULL,
    [LastUpdatedDate]       DATETIME      CONSTRAINT [DF_CignaMA_ACECustomerSummary_LastUpdatedDate] DEFAULT (getdate()) NOT NULL,
    [LastUpdatedBy]         VARCHAR (50)  CONSTRAINT [DF_CignaMA_ACECustomerSummary_LastUpdatedBy] DEFAULT (suser_sname()) NOT NULL,
    [Mbr_Name]              VARCHAR (50)  NULL,
    [DOB]                   DATE          NULL,
    [Mbr_ID]                VARCHAR (50)  NULL,
    [PCP_Name]              VARCHAR (50)  NULL,
    [PCP_NPI]               VARCHAR (15)  NULL,
    [POD]                   VARCHAR (50)  NULL,
    [Meas_Abbv]             VARCHAR (50)  NULL,
    [Eligible]              CHAR (1)      NULL,
    [Compliant]             CHAR (1)      NULL,
    [CopLoadStatus]         TINYINT       DEFAULT ((0)) NULL
);

