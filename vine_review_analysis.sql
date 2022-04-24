DROP TABLE Deliverable2_S01_TotalVotes;
DROP TABLE Deliverable2_S02_HelpfulPct;
DROP TABLE Deliverable2_S03_IsVine;
DROP TABLE Deliverable2_S04_NotVine;
DROP TABLE Deliverable2_S05_Analysis;

SELECT * 
INTO Deliverable2_S01_TotalVotes
FROM vine_table WHERE total_votes >= 20;

SELECT * 
INTO Deliverable2_S02_HelpfulPct
FROM Deliverable2_S01_TotalVotes WHERE helpful_votes / total_votes >= .5;

SELECT * 
INTO Deliverable2_S03_IsVine
FROM Deliverable2_S02_HelpfulPct WHERE vine = 'Y';

SELECT * 
INTO Deliverable2_S04_NotVine
FROM Deliverable2_S02_HelpfulPct WHERE vine = 'N';

SELECT Count_TotalReviews, Count_All5Star, 
		Count_Vine, Count_Vine5Star, 
		Cast(Count_Vine5Star / Count_All5Star as numeric(10,4)) as Pct_Vine5Star_All, 
		Cast(Count_Vine5Star / Count_Vine as numeric(10,4)) as Pct_Vine5Star_Self,
		Count_NonVine, Count_NonVine5Star, 
		Cast(Count_NonVine5Star / Count_All5Star as numeric(10,4)) as Pct_NonVine5Star_All, 
		Cast(Count_NonVine5Star / Count_NonVine as numeric(10,4)) as Pct_NonVine5Star_Self
INTO	Deliverable2_S05_Analysis
FROM (
	SELECT cast(COUNT(review_id) as float) as Count_TotalReviews, cast(SUM(CASE WHEN star_rating = 5 THEN 1 ELSE 0 END) as float) as Count_All5Star
	FROM Deliverable2_S02_HelpfulPct
	) as ii CROSS JOIN (
	SELECT cast(COUNT(review_id) as float) as Count_Vine, SUM(CASE WHEN star_rating = 5 THEN 1 ELSE 0 END) as Count_Vine5Star
	FROM Deliverable2_S03_IsVine
	) as iii CROSS JOIN (
	SELECT cast(COUNT(review_id) as float) as Count_NonVine, SUM(CASE WHEN star_rating = 5 THEN 1 ELSE 0 END) as Count_NonVine5Star
	FROM Deliverable2_S04_NotVine
	) as iv;


--SELECT * FROM Deliverable2_S01_TotalVotes;
--SELECT * FROM Deliverable2_S02_HelpfulPct;
--SELECT * FROM Deliverable2_S03_IsVine;
--SELECT * FROM Deliverable2_S04_NotVine;
SELECT * FROM Deliverable2_S05_Analysis;


