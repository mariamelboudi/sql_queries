Assessing player return

Goal: determining whether moving the gate from level 30 to level 40 increases the numner of players who return to the game.

### Describing the table
[1] Query the table to retrieve column names

##### OUTPUT
"userid", "sum_gamerounds", "retention_1", "retention_7", "version"

[2] Query the table to asses the amount of records and check for duplicates

##### OUTPUT
90189, 90189. Number of distinct user id's matches the number of records.

[3] Query the table to retrieve overall summary statistics
<br>[4] Overall summary statistics
<br>[5] Gate distribution
<br>[6] Summary statistics for each group

### Defining 'return' at day 7
[7] Overall return at day 7 (return_7 = True)
<br>[8] Overall return at day 1 (return_1 = True)
<br>[9] Compare
<br>[10] Return distribution at day 7 for both groups (gate_30, gate_40)
<br>[11] Return distribution at day 1 for both groups (gate_30, gate_40)
<br>[12] Compare

### Looking for patterns: considering the influence of returning on day 1
<br>[13] Do players have an overall higher probability of returning at day_7 if they come back at day_1? -> Compare return rates at day 7 for day_1 = true and day_1 = False
<br>[14] Do players have a higher probability of returning at day_7 if they come back at day_1 (same comparison but through versions)?

### Looking for patterns: considering the influence of sum_gamerounds
##### DISCLAIMER: some player have Day_1 AND DAY_2 false but positive sum_gamerounds. This means they returned and engaged with the game but out side of the window where data was collected
<br>[15] Do players who return on both days have higher sum_gamerounds ?
<br>[16] Do players who return later to the game, play more often ?
<br>[17] Do players who did not return at day 7 have lower sums_gamerounds ?
<br>[18] Are there super players ? If so, how many of the players do they represent ?
<br>[19] What weight do they have on the overall stats ? What to do with them ?
