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
LIMIT 10;

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
		WHEN monthly_data.minutes_songs_played = MIN(monthly_data.minutes_songs_played) OVER() 
        THEN 'Least minutes listened' 
        ELSE '' 
    END AS highest_minutes_songs_played,
	deltas.songs_percent_change,
	minutes_podcast_played,
	CASE 
        WHEN monthly_data.minutes_podcast_played = MAX(monthly_data.minutes_podcast_played) OVER() 
        THEN 'Most minutes listened'
		WHEN monthly_data.minutes_podcast_played = MIN(monthly_data.minutes_podcast_played) OVER() 
        THEN 'Least minutes listened' 
        ELSE '' 
    END AS highest_minutes_podcast_played,
	deltas.podcast_percent_change
FROM monthly_data
JOIN deltas ON monthly_data.month = deltas.month;


-- [2] NUMBER DIFFERENT ARTISTS

SELECT
	month,
	COUNT(DISTINCT master_metadata_album_artist_name) as count
FROM (
	SELECT 
		ts,
		TO_CHAR(ts, 'YYYY-MM') AS month,
		master_metadata_album_artist_name
	FROM songs
) months
GROUP BY 1
ORDER BY 1 ASC;

-- [3] NEW ARTISTS PROGRESSION

WITH first_appearance AS (
    SELECT 
        master_metadata_album_artist_name, 
        MIN(TO_CHAR(ts, 'YYYY-MM')) AS first_appearance_month
    FROM songs
    GROUP BY master_metadata_album_artist_name
)
SELECT 
    first_appearance_month, 
    COUNT(*) AS new_artist_count
FROM first_appearance
GROUP BY first_appearance_month
ORDER BY first_appearance_month ASC;


-- [4] TOP FIVE ARTISTS PER MONTH 

WITH minutes_month AS (
    SELECT 
        master_metadata_album_artist_name,
        TO_CHAR(ts, 'MM') AS month,
        ROUND(SUM(ms_played) / (1000 * 60), 0) AS total_minutes_played
    FROM songs
    GROUP BY master_metadata_album_artist_name, month
)
SELECT 
    master_metadata_album_artist_name,
    month,
    total_minutes_played,
    rank
FROM (
    SELECT 
        master_metadata_album_artist_name,
        month,
        total_minutes_played,
        ROW_NUMBER() OVER (PARTITION BY month ORDER BY total_minutes_played DESC) AS rank
    FROM minutes_month
) ranked_minutes
WHERE rank <= 5
ORDER BY month, rank;

-- [5] TOP FIVE SONGS PLAYED

WITH minutes_month AS (
    SELECT 
        master_metadata_track_name,
		master_metadata_album_artist_name,
        TO_CHAR(ts, 'MM') AS month,
        ROUND(SUM(ms_played) / (1000 * 60), 0) AS total_minutes_played
    FROM songs
    GROUP BY master_metadata_track_name, master_metadata_album_artist_name, month
)
SELECT 
    master_metadata_track_name,
	master_metadata_album_artist_name,
    month,
    total_minutes_played,
    rank
FROM (
    SELECT 
        master_metadata_track_name,
		master_metadata_album_artist_name,
        month,
        total_minutes_played,
        ROW_NUMBER() OVER (PARTITION BY month ORDER BY total_minutes_played DESC) AS rank
    FROM minutes_month
) ranked_minutes
WHERE rank <= 5
ORDER BY month, rank;

-- [6] TOP FIVE MONTHLY PODCASTS

WITH minutes_month AS (
    SELECT 
        episode_show_name,
        TO_CHAR(ts, 'MM') AS month,
        ROUND(SUM(ms_played) / (1000 * 60), 0) AS total_minutes_played
    FROM podcasts
    GROUP BY episode_show_name, month
)
SELECT 
    episode_show_name,
    month,
    total_minutes_played,
    rank
FROM (
    SELECT 
        episode_show_name,
        month,
        total_minutes_played,
        ROW_NUMBER() OVER (PARTITION BY month ORDER BY total_minutes_played DESC) AS rank
    FROM minutes_month
) ranked_minutes
WHERE rank <= 5
ORDER BY month, rank;

-- [7] TOP 5 SKIPPED SONGS

WITH skip_stats AS (
    SELECT 
        master_metadata_track_name,
        master_metadata_album_artist_name,
		TO_CHAR(ts, 'MM') AS month,
        SUM(CASE WHEN skipped = True AND reason_end = 'fwdbtn' THEN 1 ELSE 0 END) AS skipped_count
    FROM songs
    GROUP BY master_metadata_track_name, master_metadata_album_artist_name, month
) SELECT
        master_metadata_track_name,
        master_metadata_album_artist_name,
		month,
		skipped_count,
		rank
FROM (
    SELECT 
        master_metadata_track_name,
        master_metadata_album_artist_name,
		month,
		skipped_count,
        ROW_NUMBER() OVER (PARTITION BY month ORDER BY skipped_count DESC) AS rank
    FROM skip_stats
) ranked_skips
WHERE rank <= 5
ORDER BY month ASC, skipped_count DESC, rank;


-- [8] TOP TEN SONGS ON REPEAT

WITH subquery AS (
    SELECT
        master_metadata_track_name,
        master_metadata_album_artist_name,
        reason_end,
        reason_start,
        TO_CHAR(ts, 'MM') AS month,
        LEAD(reason_start, 1) OVER (PARTITION BY master_metadata_track_name, TO_CHAR(ts, 'MM') ORDER BY ts) AS next_reason_start
    FROM songs
),
condition_stats AS (
    SELECT 
        master_metadata_track_name,
        master_metadata_album_artist_name,
        month,
        COUNT(CASE
                  WHEN reason_end = 'trackdone'
                       AND next_reason_start = 'trackdone'
                  THEN 1 
                  ELSE NULL 
              END) AS repeat_count
    FROM subquery
    GROUP BY master_metadata_track_name, master_metadata_album_artist_name, month
),
ranked_stats AS (
    SELECT 
        master_metadata_track_name,
        master_metadata_album_artist_name,
        month,
        repeat_count,
        ROW_NUMBER() OVER (PARTITION BY month ORDER BY repeat_count DESC) AS rank
    FROM condition_stats
)
SELECT 
    master_metadata_track_name,
    master_metadata_album_artist_name,
    month,
    repeat_count,
    rank
FROM ranked_stats
WHERE rank <= 5
ORDER BY month ASC, rank ASC;

-- 3. SKIPPING ANALYSIS
-- Reasons for song to end

SELECT 
    reason_end,
    COUNT(*) as count,
    ROUND((COUNT(*) * 100.0) / (SELECT COUNT(*) FROM songs),1) as percent
FROM songs
GROUP BY reason_end
ORDER BY count DESC;

-- [1] SUMMARY STATS SKIPPING
	
WITH skip_counts AS (
    SELECT
        master_metadata_track_name,
        COUNT(*) AS skip_count
    FROM songs
    WHERE reason_end = 'fwdbtn' AND skipped = True
    GROUP BY master_metadata_track_name
),
percentiles AS (
    SELECT
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY skip_count) AS median_skipped,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY skip_count) AS p25_skipped,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY skip_count) AS p75_skipped
    FROM skip_counts
)
SELECT
    MIN(skip_count) AS min_skipped,
    MAX(skip_count) AS max_skipped,
    ROUND(AVG(skip_count),0) AS avg_skipped,
    (SELECT median_skipped FROM percentiles) AS median_skipped,
    (SELECT p25_skipped FROM percentiles) AS p25_skipped,
    (SELECT p75_skipped FROM percentiles) AS p75_skipped
FROM skip_counts;*/

-- [2] SKIP VARIATION FOR TOP FIVE MOST LISTENED SONGS OF YEAR

WITH skip_counts AS (
    SELECT
        master_metadata_track_name,
        COUNT(*) AS skip_count
    FROM songs
    WHERE reason_end = 'fwdbtn' AND skipped = True
    GROUP BY master_metadata_track_name
),
top_five AS (
    SELECT 
        master_metadata_track_name,
        master_metadata_album_artist_name,
        COUNT(*) AS play_count,
        ROUND(SUM(ms_played) / (1000 * 60), 0) AS total_minutes_played
    FROM songs
    GROUP BY master_metadata_track_name, master_metadata_album_artist_name
    ORDER BY play_count DESC
    LIMIT 5
)
SELECT
    TO_CHAR(ts, 'MM') AS month,
    t.master_metadata_track_name,
    COUNT(songs.skipped) AS monthly_skip_count
FROM songs
JOIN top_five t ON songs.master_metadata_track_name = t.master_metadata_track_name
WHERE songs.reason_end = 'fwdbtn' AND songs.skipped = True
GROUP BY TO_CHAR(ts, 'MM'), t.master_metadata_track_name
ORDER BY t.master_metadata_track_name, month;

WITH skip_counts AS (
    SELECT
        master_metadata_track_name,
        COUNT(*) AS skip_count
    FROM songs
    WHERE reason_end = 'fwdbtn' AND skipped = True
    GROUP BY master_metadata_track_name
),
top_five AS (
    SELECT 
        master_metadata_track_name,
        master_metadata_album_artist_name,
        COUNT(*) AS play_count,
        ROUND(SUM(ms_played) / (1000 * 60), 0) AS total_minutes_played
    FROM songs
    GROUP BY master_metadata_track_name, master_metadata_album_artist_name
    ORDER BY play_count DESC
    LIMIT 5
)
SELECT
    TO_CHAR(songs.ts, 'MM') AS month,
    t.master_metadata_track_name,
    COUNT(*) AS monthly_listens,
    COUNT(CASE WHEN songs.skipped THEN 1 END) AS monthly_skip_count,
    ROUND(COUNT(*)::NUMERIC / NULLIF(COUNT(CASE WHEN songs.skipped THEN 1 END), 0), 0) AS listen_to_skip_ratio,
    ROUND(
        (ROUND(COUNT(*)::NUMERIC / NULLIF(COUNT(CASE WHEN songs.skipped THEN 1 END), 0), 0) -
         LAG(ROUND(COUNT(*)::NUMERIC / NULLIF(COUNT(CASE WHEN songs.skipped THEN 1 END), 0), 0))
         OVER (
             PARTITION BY t.master_metadata_track_name
             ORDER BY TO_CHAR(songs.ts, 'MM')
         )
        ) /
        NULLIF(LAG(ROUND(COUNT(*)::NUMERIC / NULLIF(COUNT(CASE WHEN songs.skipped THEN 1 END), 0), 0))
               OVER (
                   PARTITION BY t.master_metadata_track_name
                   ORDER BY TO_CHAR(songs.ts, 'MM')
               ), 0) * 100, 0) AS ratio_change_percentage
FROM songs
JOIN top_five t ON songs.master_metadata_track_name = t.master_metadata_track_name
GROUP BY t.master_metadata_track_name, TO_CHAR(songs.ts, 'MM')
ORDER BY t.master_metadata_track_name, month;