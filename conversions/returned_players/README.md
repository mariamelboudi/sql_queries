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
- returned at day +1 and day +7 [+1/+7]
- returned at day +1 but not at day +7 [+1/x]
- only returned at day +7 [x/+7]
- did not return at all [x/x]

##### OUTPUT: [+1/+7]: 14.62%, [+1/x]: 29.90%, [x/+7]: 3.99%, [x/x]: 51.49%

Query the table to inspect which percentage of players did not return at all to the game.

##### OUTPUT: 4.43%

More than half the players do not return to the game at day +1 and day +7. This does not necessarily mean that they did not return to the game at all since only 4.43% of players have zero sum_gamerounds. However, this could overall show a lower engagement rate.

Query the table to see how this loss is distributed amongst the gates.

##### OUTPUT

| loss gate_30 | loss gate_40 |
|--------------|--------------|
|     2.15%    |     2.28%    |

The loss is distributed fairly amongst both gates.

Query the table to retrieve the summary statistics of the total amount of game rounds of these four conditions.

| Condition         |    Minimum   | Maximum | Mean | Median | Standard Deviation |
|-------------------|--------------|---------|------|--------|--------------------|
|Returned both days |       0      |   2961  |  187 |   130  |         192        |
|Only day +1        |       0      |  49854  |  88  |   45   |         835        |
|Only day +7        |       0      |   2640  |  50  |   32   |         60         |
|Neither days       |       0      |    981  |  12  |   6    |         21         |

Players who returned one day after downloading the game seem to have a presence of super players (max=49 854).










## Removing outliers
## Windsorized outliers
