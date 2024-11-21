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

<br> [6] How does the frequency of the age groups vary ?

| Age group |Count| Perct.|
|-----------|-----|-------|
|  seniors  |	773 |	34.88%|
|  fifties  |	669	| 30.19%|
|  fourties |	553	| 24.95%|
|  thirties |	213	| 9.61% |

<br> [4] Same for marital status ?
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
