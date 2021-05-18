﻿CREATE TABLE [adi].[CignaMA_AWV] (
    [memberid]        VARCHAR (50) NULL,
    [effectivedate]   DATE         NULL,
    [medicareid]      VARCHAR (50) NULL,
    [lastname]        VARCHAR (50) NULL,
    [firstname]       VARCHAR (50) NULL,
    [middlename]      VARCHAR (50) NULL,
    [gender]          VARCHAR (50) NULL,
    [DOB]             DATE         NULL,
    [Age]             VARCHAR (50) NULL,
    [AddressLine1]    VARCHAR (50) NULL,
    [addressline2]    VARCHAR (50) NULL,
    [city]            VARCHAR (50) NULL,
    [state]           VARCHAR (50) NULL,
    [zip]             VARCHAR (50) NULL,
    [homephone]       VARCHAR (50) NULL,
    [lastpcpvisit]    VARCHAR (50) NULL,
    [pcpid]           VARCHAR (50) NULL,
    [PCPName]         VARCHAR (50) NULL,
    [NPID]            VARCHAR (50) NULL,
    [PCPCounty]       VARCHAR (50) NULL,
    [hpcode]          VARCHAR (50) NULL,
    [pod_name]        VARCHAR (50) NULL,
    [pod_abbrev]      VARCHAR (50) NULL,
    [region]          VARCHAR (50) NULL,
    [County]          VARCHAR (50) NULL,
    [program]         VARCHAR (50) NULL,
    [diseasestate]    VARCHAR (50) NULL,
    [dualeligibility] VARCHAR (50) NULL,
    [Risk_Score]      VARCHAR (10) NULL,
    [PCPCopay]        VARCHAR (50) NULL,
    [groupid]         VARCHAR (50) NULL,
    [plan_name]       VARCHAR (50) NULL,
    [regioncode]      VARCHAR (50) NULL,
    [Hcode]           VARCHAR (50) NULL,
    [LanguageDesc]    VARCHAR (50) NULL,
    [SrcFileName]     VARCHAR (50) NULL,
    [CreatedDate]     DATETIME     CONSTRAINT [DF_adiCignaMA_AWV_CreatedDate] DEFAULT (getdate()) NULL,
    [CreateBy]        VARCHAR (50) NULL,
    [CignaMA_AWVKey]  INT          IDENTITY (1, 1) NOT NULL,
    [DataDate]        DATE         NULL,
    [FileDate]        DATE         NULL,
    [MbrLoadStatus]   TINYINT      CONSTRAINT [DF_adiCignaMA_AWVLoadStatus] DEFAULT ((0)) NOT NULL,
    [LastUpdatedDate] DATETIME     NOT NULL,
    [LastUpdatedBy]   VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_CignaMA_AWV] PRIMARY KEY CLUSTERED ([CignaMA_AWVKey] ASC)
);
