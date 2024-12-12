/*
-- 1. YEARLY ANALYSIS
-- [1] TOTAL MINUTES PLAYED
SELECT 
    ROUND(SUM(ms_played) / (1000 * 60), 0) AS total_minutes_played,
    ROUND(SUM(CASE WHEN master_metadata_track_name IS NOT NULL THEN ms_played ELSE 0 END) / (1000 * 60), 0) AS songs_total_minutes_played,
    ROUND(SUM(CASE WHEN master_metadata_track_name IS NULL THEN ms_played ELSE 0 END) / (1000 * 60), 0) AS podcast_total_minutes_played
FROM spotify24;

-- SEPARATE SONGS FROM PODCASTS

CREATE TABLE songs AS
SELECT *
FROM spotify24
WHERE master_metadata_track_name IS NOT NULL;

CREATE TABLE podcasts AS
SELECT *
FROM spotify24
WHERE master_metadata_track_name IS NULL;

-- [2] NUMBER DIFFERENT ARTISTS

SELECT COUNT(DISTINCT master_metadata_album_artist_name) AS unique_artists
FROM songs;

-- [3] NUMBER DIFFERENT PODCASTS
SELECT COUNT(DISTINCT episode_show_name) AS unique_podcasts
FROM podcasts;

-- [4] TOP FIVE ARTISTS
SELECT master_metadata_album_artist_name,
	COUNT(master_metadata_album_artist_name),
	ROUND(SUM(ms_played) / (1000 * 60), 0) AS total_minutes_played
FROM songs
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- [5] TOP FIVE PODCASTS
SELECT episode_show_name,
	COUNT(episode_show_name)
FROM podcasts
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- [6] TOP FIVE SONGS PLAYED
SELECT master_metadata_track_name,
	master_metadata_album_artist_name,
	COUNT(master_metadata_track_name),
	ROUND(SUM(ms_played) / (1000 * 60), 0) AS total_minutes_played
FROM songs
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 5;

-- [7] TOP 5 SKIPPED SONGS
WITH track_stats AS (
    SELECT 
        master_metadata_track_name,
        master_metadata_album_artist_name,
        COUNT(*) AS total_plays,
        SUM(CASE WHEN skipped = True AND reason_end = 'fwdbtn' THEN 1 ELSE 0 END) AS skipped_count
    FROM songs
    GROUP BY master_metadata_track_name, master_metadata_album_artist_name
)
SELECT 
    master_metadata_track_name,
    master_metadata_album_artist_name,
    total_plays,
    skipped_count
FROM track_stats
ORDER BY skipped_count DESC
LIMIT 5;


-- [8] TOP TEN SONGS ON REPEAT
SELECT 
       master_metadata_track_name,
       master_metadata_album_artist_name,
       COUNT(CASE
                 WHEN reason_end = 'trackdone'
                      AND next_reason_start = 'trackdone'
                 THEN 1 
                 ELSE NULL 
             END) AS condition_met
FROM (
    SELECT
           master_metadata_track_name,
           master_metadata_album_artist_name,
           reason_end,
           reason_start,
           LEAD(reason_start, 1) OVER(PARTITION BY master_metadata_track_name ORDER BY ts) AS next_reason_start
    FROM songs
) AS subquery
GROUP BY master_metadata_track_name, master_metadata_album_artist_name
ORDER BY condition_met DESC
LIMIT 10;*/

-- 2. MONTHLY ANALYSIS
-- [1] TOTAL MINUTES PLAYED
WITH monthly_data AS (
    SELECT
        TO_CHAR(ts, 'YYYY-MM') AS month,
        ROUND(SUM(ms_played) / (1000 * 60), 0) AS total_minutes_played,
        ROUND(SUM(CASE WHEN master_metadata_track_name IS NOT NULL THEN ms_played ELSE 0 END) / (1000 * 60), 0) AS minutes_songs_played,
		ROUND(SUM(CASE WHEN master_metadata_track_name IS NULL THEN ms_played ELSE 0 END) / (1000 * 60), 0) AS minutes_podcast_played
    FROM spotify24
    GROUP BY TO_CHAR(ts, 'YYYY-MM')
    ORDER BY TO_CHAR(ts, 'YYYY-MM') ASC
), deltas AS (
SELECT
	month,
	ROUND(((monthly_data.minutes_songs_played - LAG(monthly_data.minutes_songs_played, 1) OVER (ORDER BY monthly_data.month)) / LAG(monthly_data.minutes_songs_played, 1) OVER(ORDER BY monthly_data.month)) * 100, 0) AS songs_percent_change,
	ROUND(((monthly_data.minutes_podcast_played - LAG(monthly_data.minutes_podcast_played, 1) OVER (ORDER BY monthly_data.month)) / LAG(monthly_data.minutes_podcast_played, 1) OVER(ORDER BY monthly_data.month)) * 100,0) AS podcast_percent_change
FROM monthly_data
)
SELECT
    monthly_data.month,
    monthly_data.minutes_songs_played,
    CASE 
        WHEN monthly_data.minutes_songs_played = MAX(monthly_data.minutes_songs_played) OVER() 
        THEN 'Most minutes listened' 
        ELSE '' 
    END AS highest_minutes_songs_played,
	deltas.songs_percent_change,
	minutes_podcast_played,
	CASE 
        WHEN monthly_data.minutes_podcast_played = MAX(monthly_data.minutes_podcast_played) OVER() 
        THEN 'Most minutes listened' 
        ELSE '' 
    END AS highest_minutes_podcast_played,
	deltas.podcast_percent_change
FROM monthly_data
JOIN deltas ON monthly_data.month = deltas.month;


-- [2] NUMBER DIFFERENT ARTISTS

/*SELECT COUNT(DISTINCT master_metadata_album_artist_name) AS unique_artists
FROM songs;

-- [3] NUMBER DIFFERENT PODCASTS
SELECT COUNT(DISTINCT episode_show_name) AS unique_podcasts
FROM podcasts;

-- [4] TOP FIVE ARTISTS
SELECT master_metadata_album_artist_name,
	COUNT(master_metadata_album_artist_name),
	ROUND(SUM(ms_played) / (1000 * 60), 0) AS total_minutes_played
FROM songs
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- [5] TOP FIVE PODCASTS
SELECT episode_show_name,
	COUNT(episode_show_name)
FROM podcasts
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- [6] TOP FIVE SONGS PLAYED
SELECT master_metadata_track_name,
	master_metadata_album_artist_name,
	COUNT(master_metadata_track_name),
	ROUND(SUM(ms_played) / (1000 * 60), 0) AS total_minutes_played
FROM songs
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 5;

-- [7] TOP 5 SKIPPED SONGS
WITH track_stats AS (
    SELECT 
        master_metadata_track_name,
        master_metadata_album_artist_name,
        COUNT(*) AS total_plays,
        SUM(CASE WHEN skipped = True AND reason_end = 'fwdbtn' THEN 1 ELSE 0 END) AS skipped_count
    FROM songs
    GROUP BY master_metadata_track_name, master_metadata_album_artist_name
)
SELECT 
    master_metadata_track_name,
    master_metadata_album_artist_name,
    total_plays,
    skipped_count
FROM track_stats
ORDER BY skipped_count DESC
LIMIT 5;


-- [8] TOP TEN SONGS ON REPEAT
SELECT 
       master_metadata_track_name,
       master_metadata_album_artist_name,
       COUNT(CASE
                 WHEN reason_end = 'trackdone'
                      AND next_reason_start = 'trackdone'
                 THEN 1 
                 ELSE NULL 
             END) AS condition_met
FROM (
    SELECT
           master_metadata_track_name,
           master_metadata_album_artist_name,
           reason_end,
           reason_start,
           LEAD(reason_start, 1) OVER(PARTITION BY master_metadata_track_name ORDER BY ts) AS next_reason_start
    FROM songs
) AS subquery
GROUP BY master_metadata_track_name, master_metadata_album_artist_name
ORDER BY condition_met DESC
LIMIT 10;*/