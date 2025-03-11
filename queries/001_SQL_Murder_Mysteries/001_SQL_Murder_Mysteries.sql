-- Find the correct police report
SELECT *
FROM crime_scene_report
WHERE date = 20180115 AND city = 'SQL City' AND type = 'murder'

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

-- Retrieve transcripts
SELECT interview.person_id, person.name, interview.transcript 
FROM interview
LEFT JOIN person ON interview.person_id = person.id
WHERE name = 'Morty Schapiro' OR name = 'Annabel Miller'

-- Retrieve gym members with a gold membership who were at the gym on January 9th
SELECT get_fit_now_check_in.check_in_date, get_fit_now_member.name
FROM get_fit_now_member
LEFT JOIN get_fit_now_check_in ON get_fit_now_member.id = get_fit_now_check_in.membership_id
WHERE check_in_date = 20180109 AND membership_status = 'gold';

-- Connect these gym members to a driver's license and return with date and plate number as conditions
SELECT 
    get_fit_now_check_in.check_in_date, 
    get_fit_now_member.name, 
    drivers_license.plate_number 
FROM get_fit_now_member
LEFT JOIN get_fit_now_check_in ON get_fit_now_member.id = get_fit_now_check_in.membership_id
LEFT JOIN person ON get_fit_now_member.person_id = person.id
LEFT JOIN drivers_license ON person.license_id = drivers_license.id
WHERE check_in_date = 20180109 AND plate_number LIKE '%H42W%';

-- Retrieve the interview transcript for Jeremy Bowers
SELECT person.name, interview.transcript
FROM person
LEFT JOIN interview ON person.id = interview.person_id
WHERE name = 'Jeremy Bowers';

-- Retrieve the names of people who attended the SQL Concert Symphony three times in December 2017
SELECT facebook_event_checkin.person_id, person.name
FROM facebook_event_checkin
LEFT JOIN person ON facebook_event_checkin.person_id = person.id
WHERE event_name = 'SQL Symphony Concert' AND date BETWEEN '20171201' AND '20171231'
GROUP BY 1
HAVING COUNT(person_id) = 3;

-- Retrieve the car models for these two people
SELECT person.name, drivers_license.car_make, drivers_license.car_model
FROM person
LEFT JOIN drivers_license ON person.license_id = drivers_license.id
WHERE person.name = 'Miranda Priestly' OR person.name = 'Bryan Pardo';

-- Retrieve full description of Miranda Priestly
SELECT person.name, drivers_license.*
FROM drivers_license
LEFT JOIN person ON drivers_license.id = person.license_id
WHERE person.name = 'Miranda Priestly';

-- Check answer
INSERT INTO solution VALUES (1, 'Miranda Priestly');
        
        SELECT value FROM solution;
