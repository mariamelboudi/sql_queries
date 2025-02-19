# Spotify wrapped 2024

Each year, Spotify delivers its famous and long awaited 'Spotify wrapped', which gives users a personal overview of their listening trends throughout the year. Surprised to be labelled a 'pop pilates princess', I requested my data and conducted my own analysis  (sadly, this turns out to be quite accurate).
<br><br>Section three is a personal addition; <b>the skipping rate</b>. Being quite fond of listening to the same track on repeat until I am sick of it, I wondered how my listening-to-skip ratio varied over time for my year-long favourite tracks.
<br><br>I also added my <b>monthly discovery of new artists</b>, another feature that would make sense as it conveys a sense of developing musical tastes and expanding curiosity rather than reinforcing a rigid label confined to a narrow corner of the internet.

Happy New Year ! ✨

## 1. Yearly analysis

### 1. Total number of minutes played

|Total|Songs|Podcasts|
|-----|-----|--------|
|49844|32886|	16958  |
		

### 2. 1498 different artists
### 3. 158 different podcasts
### 4. Top 5 artists

| Artist        |Count|Minutes Played|
|---------------|-----|--------------|
| Billie Eilish |813  |2092          |
| Kendrick Lamar|588  |1771          |
| Miley Cyrus   |546  |1213          |
| Ariana Grande |522  |1114          |
| Dua Lipa      |506  |1156          |

### 5. Top 5 podcasts

| Podcast         | Episodes Listened |
|-----------------|-------------------|
| Was I In A Cult?| 41                |
| Gone South      | 41                |
| Conspirituality | 36                |
| Search Engine   | 33                |
| Méta de Choc    | 28                |

### 6. Top 5 songs played

| Track                                     | Artist             | Count | Minutes Played |
|-------------------------------------------|--------------------|-------|----------------|
| BURN                                      | ¥$                 | 214   | 350            |
| Forest Nymph                              | Sophie Woodhouse   | 188   | 182            |
| L’AMOUR DE MA VIE [OVER NOW EXTENDED EDIT]| Billie Eilish      | 177   | 571            |
| La Tortura - Spotify Singles              | Judeline           | 167   | 383            |
| No One Dies From Love                     | Tove Lo            | 140   | 357            |
| Disease                                   | Lady Gaga          | 138   | 431            |

### 7. Top 5 skipped songs

| Track                                                    | Artist     | Total Plays | Skip Count |
|-----------------------------------------------------------------------|-------------------|-------------|------------|
| How Would They Know                                                    | Anetha            | 95          | 89         |
| I Can't Make You Love Me                                               | Bonnie Raitt      | 35          | 30         |
| Set Me Free                                                            | Ken Boothe        | 37          | 29         |
| What Happened to Your Heart | Peter Broderick           | 29          | 25         |
|L’AMOUR DE MA VIE [OVER NOW EXTENDED EDIT]| Billie Eilish| 177         | 23         |

### 8. Top 10 songs on repeat

| Song Title                                        | Artist              | Count      |
|---------------------------------------------------|---------------------|------------|
| BURN                                              | ¥$                  | 158        |
| La Tortura - Spotify Singles                      | Judeline            | 139        |
| L’AMOUR DE MA VIE [OVER NOW EXTENDED EDIT]        | Billie Eilish       | 105        |
| Something About Us                                | Daft Punk           | 103        |
| No One Dies From Love                             | Tove Lo             | 100        |
| Disease                                           | Lady Gaga           | 94         |
| Muddy Feet (feat. Sia)                            | Miley Cyrus         | 89         |
| One Of Your Girls                                 | Troye Sivan         | 75         |
| Training Season                                   | Dua Lipa            | 73         |
| Not Like Us                                       | Kendrick Lamar      | 67         |

## 2. Monthly analysis
### 1. Minutes listened
Breakdown of how many minutes were listened, aggregated by songs or podcasts; month to month variation calculated as a percent and flagging of the highest and lowest amount of minutes listened per category.

![002 01 Monthly_listening](https://github.com/user-attachments/assets/43ee7bf9-9d70-4fb0-9246-d9cd418fafc8)

### 2. Distinct artists
![002 02 Monthly_distinct_artists](https://github.com/user-attachments/assets/ffe52a87-5aa8-44d4-933a-35b298df09e2)

### 3. New artists per month

![002 03 Monthly_new_artists](https://github.com/user-attachments/assets/4666d937-a106-4488-bfb7-f897e55fb4bd)

### 4. Top 5 monthly artists (excerpt)

![002 04 Top5monthly](https://github.com/user-attachments/assets/56037083-aa73-479b-ab00-1c91669a14c5)

### 5. Top 5 monthly tracks (excerpt)
Note: the ranking is based on the total amount of minutes played per month. An alternative method of aggregation would have been to count the number of times (COUNT()) the track was played regardless of whether it was played entirely or not.

![002 05 Top5monthlytracks](https://github.com/user-attachments/assets/1588bab4-b12a-4ae5-b824-5bf224d42b59)

### 6. Top 5 monthly podcasts (excerpt)

![002 06 Top5monthlypodcasts](https://github.com/user-attachments/assets/565bf00a-16aa-4848-96d6-4d9fd5601292)

### 7. Top 5 monthly skipped tracks (excerpt)

![002 07 Top5monthlyskippedtracks](https://github.com/user-attachments/assets/08088eb3-3a98-4863-8642-92f15355b57a)

### 8. Top 5 monthly tracks on repeat (excerpt)

![002 08 Top5monthlyrepeattracks](https://github.com/user-attachments/assets/6c31a95c-bd9a-440d-91ef-deb9b035f9b8)

## 3. Skipping analysis

### Reasons for the track to end

| Reason End                      | Count     | Percent Skipped |
|---------------------------------|-----------|-----------------|
| trackdone                       | 8545      | 58.1%           |
| fwdbtn                          | 3300      | 22.4%           |
| endplay                         | 2033      | 13.8%           |
| logout                          | 367       | 2.5%            |
| unexpected-exit-while-paused    | 230       | 1.6%            |
| backbtn                         | 211       | 1.4%            |
| trackerror                      | 11        | 0.1%            |
| unexpected-exit                 | 6         | 0.0%            |
| remote                          | 1         | 0.0%            |

### 1. Summary statistics on skipping rates

|Min.|Max.|Avg.|Median.|1st quart.|3 quart.|
|----|----|----|-------|----------|--------|
|1   |89  |2   |1      |1         |2       |

### 2. Monthly skip counts, listens, listen-to-skip ratio
##### For top five songs of the year

The listen-to-skip ratio decreases over each month. For example, in February the song 'BURN' would take on average 11 listens before being skipped. By March, it only took 6 listens to be skipped.

![003 02 Monthlyskipcountsvslistensskipratio](https://github.com/user-attachments/assets/240bd2ea-41e9-4da0-9ea3-7ff1aab1ab11)

