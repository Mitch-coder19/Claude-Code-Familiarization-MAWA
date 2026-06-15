/* =====================================================================
   schema.sql  -  SYNTHETIC DEMO schema (Make-A-Wish America IT)
   Sample fake star-ish schema for the "generate a data dictionary" demo.
   All tables/columns are fabricated for demonstration only.
   ===================================================================== */

CREATE TABLE dbo.Chapters (
    ChapterId     INT            NOT NULL IDENTITY(1,1),
    ChapterCode   VARCHAR(10)    NOT NULL,
    ChapterName   VARCHAR(100)   NOT NULL,
    Region        VARCHAR(50)    NULL,
    State         CHAR(2)        NULL,
    IsActive      BIT            NOT NULL CONSTRAINT DF_Chapters_IsActive DEFAULT(1),
    CONSTRAINT PK_Chapters PRIMARY KEY (ChapterId),
    CONSTRAINT UQ_Chapters_Code UNIQUE (ChapterCode)
);

CREATE TABLE dbo.Coordinators (
    CoordinatorId INT            NOT NULL IDENTITY(1,1),
    FullName      VARCHAR(120)   NOT NULL,
    Email         VARCHAR(150)   NULL,
    ChapterId     INT            NOT NULL,
    HireDate      DATE           NULL,
    CONSTRAINT PK_Coordinators PRIMARY KEY (CoordinatorId),
    CONSTRAINT FK_Coordinators_Chapter FOREIGN KEY (ChapterId) REFERENCES dbo.Chapters(ChapterId)
);

CREATE TABLE dbo.Donors (
    DonorId       INT            NOT NULL IDENTITY(1,1),
    DonorName     VARCHAR(150)   NOT NULL,
    DonorType     VARCHAR(30)    NULL,   -- Individual / Corporate / Foundation
    Email         VARCHAR(150)   NULL,
    ChapterId     INT            NULL,
    TotalGivenUsd DECIMAL(14,2)  NOT NULL CONSTRAINT DF_Donors_Total DEFAULT(0),
    CONSTRAINT PK_Donors PRIMARY KEY (DonorId),
    CONSTRAINT FK_Donors_Chapter FOREIGN KEY (ChapterId) REFERENCES dbo.Chapters(ChapterId)
);

CREATE TABLE dbo.Referrals (
    ReferralId    INT            NOT NULL IDENTITY(1,1),
    ChildAlias    VARCHAR(80)    NOT NULL,   -- de-identified alias only
    ReferralSource VARCHAR(80)   NULL,       -- Physician / Parent / Self / Social Worker
    DateReferred  DATE           NOT NULL,
    ChapterId     INT            NOT NULL,
    IsEligible    BIT            NULL,
    CONSTRAINT PK_Referrals PRIMARY KEY (ReferralId),
    CONSTRAINT FK_Referrals_Chapter FOREIGN KEY (ChapterId) REFERENCES dbo.Chapters(ChapterId)
);

CREATE TABLE dbo.Wishes (
    WishId        INT            NOT NULL IDENTITY(1,1),
    ReferralId    INT            NULL,
    ChapterId     INT            NOT NULL,
    CoordinatorId INT            NULL,
    WishType      VARCHAR(100)   NULL,   -- I Wish To Go / Have / Be / Meet
    DateReferred  DATE           NULL,
    DateGranted   DATE           NULL,
    CostUsd       DECIMAL(12,2)  NULL,
    Status        VARCHAR(30)    NOT NULL CONSTRAINT DF_Wishes_Status DEFAULT('Open'),
    CONSTRAINT PK_Wishes PRIMARY KEY (WishId),
    CONSTRAINT FK_Wishes_Referral FOREIGN KEY (ReferralId) REFERENCES dbo.Referrals(ReferralId),
    CONSTRAINT FK_Wishes_Chapter FOREIGN KEY (ChapterId) REFERENCES dbo.Chapters(ChapterId),
    CONSTRAINT FK_Wishes_Coordinator FOREIGN KEY (CoordinatorId) REFERENCES dbo.Coordinators(CoordinatorId)
);

CREATE TABLE dbo.WishDonations (
    WishDonationId INT           NOT NULL IDENTITY(1,1),
    WishId        INT            NOT NULL,
    DonorId       INT            NOT NULL,
    AmountUsd     DECIMAL(12,2)  NOT NULL,
    DonationDate  DATE           NOT NULL,
    CONSTRAINT PK_WishDonations PRIMARY KEY (WishDonationId),
    CONSTRAINT FK_WishDonations_Wish FOREIGN KEY (WishId) REFERENCES dbo.Wishes(WishId),
    CONSTRAINT FK_WishDonations_Donor FOREIGN KEY (DonorId) REFERENCES dbo.Donors(DonorId)
);
