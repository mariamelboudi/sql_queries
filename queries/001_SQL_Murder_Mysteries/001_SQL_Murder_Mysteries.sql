SELECT DISTINCT description
FROM crime_scene_report
WHERE description NOT IN (SELECT transcript FROM interview);

SELECT *
FROM crime_scene_report
WHERE description = 'Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".';

-- Witness n°1
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;

-- Witness n°2
SELECT *  
FROM person  
WHERE name LIKE '%Annabel%' AND address_street_name = 'Franklin Ave'; 
