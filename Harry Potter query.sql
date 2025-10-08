-- Harry Potter Dataset SQL Project
-- Purpose: EDA + Business Insights using HP data

-- 1. Who are the main characters at Hogwarts?

SELECT * FROM "character"
LIMIT 10;

--2. When were the Harry Potter movies released?

SELECT movie_title, release_year FROM movies ORDER BY release_year;

-- 3. Which spell is most frequently cast in the books?

SELECT spell_name, COUNT(*) AS usage_count
FROM spells
GROUP BY spell_name
ORDER BY usage_count DESC
LIMIT 1;

-- 4. Find most place name by dialogues

SELECT  p.place_name, d.dialogues, COUNT(p.place_id) AS total_count 
FROM places p
JOIN Dialogue d ON d.place_id = p.place_id
GROUP BY place_name, d.dialogues
ORDER BY total_count DESC
LIMIT 5;

-- 5. Movie ROI
SELECT 
    movie_title,
    release_year,
    budget,
    box_office,
    (box_office - budget) AS profit,
    ROUND(((box_office - budget) * 100.0 / budget), 2) AS roi_percentage
FROM movies

-- 6. Top Places by Activity

SELECT 
    p.place_name,
    p.place_category,
    COUNT(d.dialogue_id) AS lines_spoken,
    COUNT(DISTINCT d.character_id) AS unique_characters_
FROM places p
LEFT JOIN Dialogue d ON d.place_id = p.place_id
GROUP BY p.place_name, p.place_category
ORDER BY lines_spoken DESC
LIMIT 10;

-- 7. Popular 3 chapters by dialogues

SELECT c.chapter_name, d.dialogues, COUNT(d.dialogue_id) AS total_dialogues
FROM Chapters c
JOIN Dialogue d ON d.chapter_id = c.chapter_id
GROUP BY c.chapter_name, d.dialogues
ORDER BY total_dialogues DESC
LIMIT 3;

-- 8. Top movies with runtime between 140 & 160
SELECT movie_title, release_year, runtime
FROM movies
WHERE runtime BETWEEN 140 AND 160
ORDER BY runtime DESC;

-- 9.  Find the highest chapter name for each movie

SELECT c.chapter_name, m.movie_title, m.release_year
FROM movies m
JOIN Chapters c
ON m.movie_id = c.movie_id 
WHERE c.movie_chapter = (
 SELECT MAX(c.movie_chapter)
 FROM Chapters c
 WHERE c.movie_id = m.movie_id

);

-- 10. Analyse spells by incantation complexity 

SELECT incantation, COUNT(*) AS times_used
FROM spells 
GROUP BY incantation
ORDER BY times_used DESC;

-- 11. Which movie had the most dialogues?

SELECT m.movie_title, COUNT(dialogue_id) AS
total_dialogues
FROM Dialogue d
JOIN Chapters ch ON d.chapter_id = ch.chapter_id
JOIN movies m ON ch.movie_id = m.movie_id
GROUP BY m.movie_title
ORDER BY total_dialogues DESC
LIMIT 1;
 
-- 12. List of all characters who belong to Gryffindor House?

SELECT "Name", "House"
FROM Character 
WHERE "House" = 'Gryffindor';
    
-- 13. Which house has the highest number of students?

SELECT "House", COUNT(*) AS total_students
FROM Character
GROUP BY "House"
ORDER BY total_students DESC
LIMIT 1;
