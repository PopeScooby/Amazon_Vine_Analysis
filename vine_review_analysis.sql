DROP TABLE Deliverable2_S01_TotalVotes;
DROP TABLE Deliverable2_S02_HelpfulPct;
DROP TABLE Deliverable2_S03_IsVine;
DROP TABLE Deliverable2_S04_NotVine;

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

--SELECT * FROM Deliverable2_S01_TotalVotes;
--SELECT * FROM Deliverable2_S02_HelpfulPct;
--SELECT * FROM Deliverable2_S03_IsVine;

SELECT Count_TotalReviews, Count_All5Star, 
		Count_Vine5Star, Cast(Count_Vine5Star / Count_All5Star as numeric(10,4)) as Pct_Vine5Star, 
		Count_NonVine5Star, cast(Count_NonVine5Star / Count_All5Star as numeric(10,4)) as Pct_NonVine5Star
FROM (
	SELECT COUNT(review_id) as Count_TotalReviews
	FROM Deliverable2_S02_HelpfulPct
	) as ii CROSS JOIN (
	SELECT cast(COUNT(review_id) as float) as Count_All5Star
	FROM Deliverable2_S02_HelpfulPct
	WHERE star_rating = 5
	) as iii CROSS JOIN (
	SELECT Cast(COUNT(review_id) as float) as Count_Vine5Star
	FROM Deliverable2_S03_IsVine
	WHERE star_rating = 5
	) as iv CROSS JOIN (
	SELECT cast(COUNT(review_id) as float) as Count_NonVine5Star
	FROM Deliverable2_S04_NotVine
	WHERE star_rating = 5
	) as v












