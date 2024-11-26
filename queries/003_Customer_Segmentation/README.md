Customer segmentation is the practice of separating customers into groups that reflect similarities among customers in each cluster.
By determining profiles and customer behavioral trends, it is possible to identify potential new customers.


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

<br> [3] What are the different levels of education ? How is this distributed amongst them ?
<br> [5] What is the highest income ? The lowest ? The span ? How does the income vary ? What is the highest income for each marital status ? For each education level ? How does the income span for each education level ? For each marital status ?
<br> [6] How many customers have kids at home ? Teens at home ? Both ? One or the other ? None at all ?

<br> RFM Analysis (Recency, Frequency, Monetary):

Recency: How recently a customer made a purchase.
<br> Frequency: How often they make a purchase.
<br> Monetary: How much money they spend.
<br> Demographic Segmentation: Based on age, income, marital status, etc.

<br> Behavioral Segmentation: Based on purchasing habits, product preferences, etc

<br> [7] When was the earliest registration ? The last ? The span ? [dt series in Tableau]
<br> [8] What is the average amount spent on wine ? On fruits ? On meat ? On fish ? On sweets ? On gold ? Which category spends the most on each ? Which combined (education + marital_status) category spends the most on each ?
<br> [9] What is the preferred purchase method (web, store, etc) depending on the age ? the category ?
<br> [10] How does each segment vary in their purchasing habit ? How can we classify them according to it ?
