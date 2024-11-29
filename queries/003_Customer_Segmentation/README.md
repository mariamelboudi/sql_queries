Customer segmentation is the practice of separating customers into groups that reflect similarities among customers in each cluster.
By determining profiles and customer behavioral trends, it is possible to identify potential new customers.

## Customer base analysis

[1] How many customers are in the table ?
##### OUTPUT: 2240
[2] Are there any duplicates ?
##### OUTPUT: 0
[3] Are there any missing values? What do we do with them ?
##### 24 missing values in the revenue column. Deleting them will result in losing 1% of the table, which is negligeable.

<br> [4] How old is the oldest customer ? The youngest ? What is the age span ? What is the average age ?
##### OUTPUT
|Oldest year|Youngest year|Oldest age|Youngest age|Age span|Average age|
|-----------|-------------|----------|------------|--------|-----------|
|    1940   |   1999      |     84   |     25     |   59   |     55    |


<br> [5] What is the most common birth year ?
##### OUTPUT
|            |Year|Count|
|------------|----|-----|
|Most common |1976|  89 |
|Least common|1941|  1  |
|            |1999|  1  |

[6] How does the customer age vary ? Can we define age groups ?

|Age group|Count| Pctg |
|---------|-----|------|
|Seniors  | 772 |34.90%|
|Fifties  | 667 |30.15%|
|Fourties | 553 |   25%|
|Thirties | 212 | 9.58%|
|Twenties |  8  | 0.36%|

Senior customers (60 and over) count for over one third of the customer base. They are closely followed by customers in their fifties, who represent 30% of the customers, and those in their fourties. There are only 8 customers in their twenties, which counts for people between the ages of 18 and 29 included.

<br> [7] What are the different marital statuses ? How are they distributed ?

|Marital status|Count| Pctg |
|--------------|-----|------|
|   Married    | 857 |38.74%|
|  Together    | 573 |25.90%|
|    Single    | 474 |21.43%|
|  Divorced    | 232 |10.49%|
|     Widow    |  76 | 3.44%|

<br> [8] What are the different levels of education ? How is this distributed amongst each age group ? Amongst each marital status group ?
##### Distribution of education levels
|Education |Count| Pctg |
|----------|-----|------|
|Graduation|1115 |50.41%|
|PhD       | 479 |21.65%|
|Master    | 364 |16.46%|
|2n Cycle  | 200 |9.04% |
|Basic     |  54 | 2.44%|

##### Distribution of education levels amongst age groups
|Education   |Twenties|Thirties|Fourties|Fifties|Seniors|
|------------|--------|--------|--------|-------|-------|
|2n Cycle    |	1.50% |	13.50% | 37.50% |22.50% |  25%  |
|Basic       |	1.85% |	31.48% | 33.33% |18.52% |14.81% |
|Graduation  |	0.27% |	10.49% | 26.28% |29.96% |	 33%  |
|Master      |	  0%  |	 6.59% | 22.25% |31.59% |39.56% |
|PhD	       |  0.21% |	 5.64% | 17.95% |34.03% |42.17% |

##### Distribution of education levels amongst marital statuses
|Education   |Together|Married |Widowed |Divorced|Single|
|------------|--------|--------|--------|--------|------|
|2n Cycle    |	 28%  |   40%  |  2.5%  |  11.5% |  18% |
|Basic       | 25.93% |	37.04% |  1.85% |  1.85% |33.33%|
|Graduation  | 25.56% |	38.48% |  3.14% | 10.67% |22.15%|
|Master      | 28.02% |	37.91% |  3.02% | 10.16% |20.88%|
|PhD	       | 24.22% |	39.67% |  5.01% | 10.86% |20.25%|


<br> [9] What is the highest income ? The lowest ? The span ? How does the income vary ?

|Lowest|Highest |Average |Standard Dev.|Median |
|------|--------|--------|-------------|-------|
|1730.0|666666.0|52232.51|   25187.46  |51390.0|


How does this vary depending on marital status ?

|Marital status| Lowest |Highest |Average |Standard Dev.|Median |
|--------------|--------|--------|--------|-------------|-------|
|    Married   | 2447.0 |160803.0|51724.98|   21449.41  |51876.0|
|   Together   | 5648.0	|666666.0|53245.53|	  33644.10	|51369.0|
|    Single    | 3502.0	|113734.0|50949.74|	  22188.39	|48904.0|
|   Divorced   | 1730.0	|153924.0|52834.23|   21239.76	|53034.0|
|    Widow	   | 22123.0|85620.0 |56481.55|   16837.95	|56551.0|

On education level ?

| Education Level |Lowest |Highest |Average  |Standard Dev.|Median |
|-----------------|-------|--------|---------|-------------|-------|
| Basic           | 7500.0|34445.0 | 20306.26| 6235.07     |21063.0|
| 2n Cycle        | 7500.0|96547.0 | 47633.19| 22119.08    |46831.0|
| Master          | 6560.0|157733.0| 52883.00| 20174.72    |50943.0|
| Graduation      | 1730.0|666666.0| 52696.59| 28178.62    |51983.0|
| PhD             | 4023.0|162397.0| 56177.52| 20650.01    |55212.0|

<br> [10] How many customers have kids at home ? Teens at home ? Both ? One or the other ? None at all ?

|          |Kids  |Teens |Kids only |Teens only|Both  |None  |
|----------|------|------|----------|----------|------|------|
|Count     | 933  |1067  |    514   |   648    |  419	|  631 |
|Percentage|42.18%|48.24%|  23.24%  |  29.29%  |18.94%|28.53%|


## RFM Analysis (Recency, Frequency, Monetary):

Recency: How recently a customer made a purchase.
<br> Frequency: How often they make a purchase.
<br> Monetary: How much money they spend.
<br> Demographic Segmentation: Based on age, income, marital status, etc.

<br> Behavioral Segmentation: Based on purchasing habits, product preferences, etc

<br> [7] When was the earliest registration ? The last ? The span ? [dt series in Tableau]
<br> [8] What is the average amount spent on wine ? On fruits ? On meat ? On fish ? On sweets ? On gold ? Which category spends the most on each ? Which combined (education + marital_status) category spends the most on each ?
<br> [9] What is the preferred purchase method (web, store, etc) depending on the age ? the category ?
<br> [10] How does each segment vary in their purchasing habit ? How can we classify them according to it ?
