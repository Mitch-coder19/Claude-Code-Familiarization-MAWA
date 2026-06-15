CREATE PROCEDURE dbo.usp_WishSummary
    @FiscalYear INT,
    @ChapterCode VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE #base (
        WishId INT,
        ChapterId INT,
        CoordinatorId INT,
        WishType VARCHAR(100),
        DateReferred DATE,
        DateGranted DATE,
        CostUsd DECIMAL(12,2),
        DaysToGrant INT
    );

    INSERT INTO #base (WishId, ChapterId, CoordinatorId, WishType, DateReferred, DateGranted, CostUsd, DaysToGrant)
    SELECT w.WishId, w.ChapterId, w.CoordinatorId, w.WishType, w.DateReferred, w.DateGranted, w.CostUsd,
           DATEDIFF(DAY, w.DateReferred, w.DateGranted)
    FROM dbo.Wishes w
    WHERE w.DateReferred >= DATEFROMPARTS(@FiscalYear, 9, 1)
      AND w.DateReferred <  DATEFROMPARTS(@FiscalYear + 1, 9, 1);

    IF @ChapterCode IS NOT NULL
    BEGIN
        DELETE b
        FROM #base b
        JOIN dbo.Chapters c ON c.ChapterId = b.ChapterId
        WHERE c.ChapterCode <> @ChapterCode;
    END

    SELECT b.ChapterId, COUNT(*) AS WishCount, AVG(CAST(b.DaysToGrant AS FLOAT)) AS AvgDays, SUM(b.CostUsd) AS TotalCost
    INTO #agg
    FROM #base b
    GROUP BY b.ChapterId;

    UPDATE a
    SET a.AvgDays = 0
    FROM #agg a
    WHERE a.AvgDays IS NULL;

    SELECT t.ChapterId, t.CoordinatorId, COUNT(*) AS CoordCount
    INTO #coord
    FROM #base t
    GROUP BY t.ChapterId, t.CoordinatorId;

    SELECT
        c.ChapterName,
        c.ChapterCode,
        a.WishCount,
        a.AvgDays,
        a.TotalCost,
        (SELECT TOP 1 co.FullName
           FROM #coord x
           JOIN dbo.Coordinators co ON co.CoordinatorId = x.CoordinatorId
          WHERE x.ChapterId = a.ChapterId
          ORDER BY x.CoordCount DESC) AS TopCoordinator,
        CASE WHEN a.WishCount = 0 THEN 0 ELSE a.TotalCost / a.WishCount END AS AvgCostPerWish
    FROM #agg a
    JOIN dbo.Chapters c ON c.ChapterId = a.ChapterId
    ORDER BY a.TotalCost DESC;

    DROP TABLE #coord;
    DROP TABLE #agg;
    DROP TABLE #base;
END
