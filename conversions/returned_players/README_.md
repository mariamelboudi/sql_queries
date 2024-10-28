# Assessing player return
This dataset examines whether or not moving a gate from level 30 to level 40 impacts significantly the number of returned players at day 7.


##### This series of queries follows three steps. First, we pull and examine the data without manipulating it. Then, we examine it by removing the outliers. Finally, we examine it again with windsorized outliers.

## Without data manipulation
### Examining the dataset

First, we count the number of distinct 'userid' and compare it to the 'userid' count in order to check for duplicates. In this case, both queries return an identical output, indicating there are no duplicates in the table.

Querying the unique 'version's that are recorded allows us to check how many versions of the game are being tested. It also allows to check for faulty recordings that would compromise the analysis.

##### OUTPUT: 'gate_30', 'gate_40'

Querying the distinct values recorded for 'retention_1' and 'retention_7' returns boolean values recorded as 'true'/'false'.

We query the summary statistics on the total amount of games played by all the participants ('sum_gamerounds'). These statistics include: the minimum, the maximum, the mean, the median and the standard deviation.

##### OUTPUT Min: 0, Max: 49 854, Mean: 52, Median: 16, Standard deviation: 195. This indicates right-skewedness and a possible presence of super players.

We create a common table expression that queries the count of users in each version group and divides it by the total number of users to assess how the gates were distributed amongst the players. We multiply the result by 100 to return a percentage. In this case it was fairly even for 'gate_30' and 'gate_40'.

##### OUTPUT (respectively): 49.56, 50.44

We calculate the percentage of players who downloaded the game and:
- returned at day +1 and day +7
- returned at day +1 but not at day
- only returned at day +7
- return other days

##### OUTPUT:

|Return condition   | Percentage |
|-------------------|------------|
|Returned both days |   14.62%   |
|Only day +1        |   29.90%   |
|Only day +7        |    3.99%   |
|Other days         |   51.49%   |


More than half the players do not return to the game at day +1 and day +7. This does not necessarily mean that they did not return to the game at all since only 4.43% of players have zero sum_gamerounds. However, this could overall show a lower engagement rate.

Query the table to inspect which percentage of players did not return at all to the game.

##### OUTPUT: 4.43%
Query the table to see how this loss is distributed amongst the gates.

##### OUTPUT

| loss gate_30 | loss gate_40 |
|--------------|--------------|
|     2.15%    |     2.28%    |

The loss is distributed fairly amongst both gates.

Query the table with a condition that separates the players that did not return at all to the game and those who returned on days other than day+1 and day+7.

##### OUTPUT:

|Return condition   | Percentage |
|-------------------|------------|
|Returned both days |   14.62%   |
|Only day +1        |   29.90%   |
|Only day +7        |    3.99%   |
|Other days         |   47.18%   |
|Did not return     |    4.31%   |

Query the table to examine player return behaviour.
##### OUTPUT

|Return condition   | Percentage |
|-------------------|------------|
|Returned both days |   14.62%   |
|Only day +1        |   29.90%   |
|Only day +7        |    3.99%   |
|Other days (once)  |    5.91%   |
|Other days (> 1)   |   41.27%   |
|Did not return     |    4.31%   |


Query the table to retrieve the summary statistics of the total amount of game rounds of the players for these four conditions.

| Condition         |    Minimum   | Maximum | Mean | Median | Standard Deviation |
|-------------------|--------------|---------|------|--------|--------------------|
|Returned both days |       0      |   2961  | 187  |   130  |         192        |
|Only day +7        |       0      |   2640  |  50  |    32  |          60        |
|Only day +1        |       0      |  49854  |  88  |    45  |         835        |
|Other days         |       0      |    981  |  12  |     6  |          21        |

Query again to retrieve the summary statistics of the sum_gamerounds of only the players who did return to the game (ie removing players who did not return)

| Condition         |    Minimum   | Maximum | Mean | Median | Standard Deviation |
|-------------------|--------------|---------|------|--------|--------------------|
|Overall stats      |       0      |  49854  |  52  |    16  |         195        |
|Returned both days |       0      |   2961  | 187  |   130  |         192        |
|Only day +1        |       0      |   2640  |  50  |    32  |          60        |
|Only day +7        |       0      |  49854  |  88  |    45  |         835        |
|Other days         |       1      |    981  |  13  |     7  |          22        |

Query the table to retrieve the summary statistics of the total amount of game rounds of the palyers who returned.

Players who returned one day after downloading the game seem to have a presence of super players (max=49 854).
Furthermore, these conditions show a minimim of 0 sum_gamerounds inspite of the players returning to the game.

The initial question was: does moving a gate from level 30 to level 40 increase player return on day 7. Let's focus on this.

Query the table to assess overallplayer return rates depending on the gates et day 1 and day 7


Is there a trend (t-test) between sum_games and return rate ?


## RETURN VS ENGAGEMENT
Return is the condition where a player opens the game, regardless of whether or not they start or complete a gameround.
Engagement is return + a completed gameround. Let's assess the amount of friction ie return without starting/completing a gameround.

Query the table to assess the overall return versus engagement rate. 'Return' is defined as having zero game rounds, whereas 'engagement' is defined as a positive amount of game rounds.

##### OUTPUT
|Return| Engagement |
|------|------------|
|4.43% |    99.57%  |

Query the table to retrieve a difference according to the gate.


|GATE 30 (Return)|GATE 30 (Engagement)|GATE 40 (Return)|GATE 40 (Engagement) |
|----------------|--------------------|---------------|----------------------|
| 4.33%          | 95.67%             | 4.52%         | 95.48%               |



## Removing outliers
## Windsorized outliers
