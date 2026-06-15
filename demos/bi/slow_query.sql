/* =====================================================================
   slow_query.sql  -  SYNTHETIC DEMO (Make-A-Wish America IT)
   This query RUNS SLOW on purpose. It is the input for the
   "optimize a slow query" demo. All tables/data are fabricated.

   Known smells planted here:
     - SELECT *  (returns every column, no covering index possible)
     - Functions on columns in the WHERE clause (kills sargability)
     - Implicit data-type conversion on a join/filter column
     - A correlated subquery in the SELECT list (runs per row)
     - Leading-wildcard LIKE (forces a scan)
     - No useful indexed predicate
   ===================================================================== */

SELECT *
FROM dbo.Wishes        AS w
JOIN dbo.Chapters      AS c  ON CONVERT(VARCHAR(50), w.ChapterId) = c.ChapterCode   -- implicit/explicit conversion, type mismatch
JOIN dbo.Coordinators  AS co ON co.CoordinatorId = w.CoordinatorId
WHERE YEAR(w.DateReferred) = 2025                              -- function on column -> non-sargable
  AND UPPER(c.ChapterName) LIKE '%ARIZONA%'                    -- function + leading wildcard
  AND DATEDIFF(DAY, w.DateReferred, w.DateGranted) > 30        -- function on columns
  AND ISNULL(w.WishType, '') <> ''
ORDER BY
    (SELECT COUNT(*)                                           -- correlated subquery in ORDER BY, evaluated per row
       FROM dbo.Wishes wq
      WHERE wq.CoordinatorId = w.CoordinatorId) DESC,
    w.CostUsd DESC;
