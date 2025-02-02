# Business analysis

This dataset provided by the [UCI machine learning repository](https://archive.ics.uci.edu/dataset/352/online+retail) contains over 600 000 lines and is a 'transactional data set which contains all the transactions occurring between 01/12/2010 and 09/12/2011 for a UK-based and registered non-store online retail.'

![01 describe](https://github.com/user-attachments/assets/bf933324-2ba1-4e0d-977c-106518a2bfe3)

## 1. Data cleaning

The major issues of this dataset were:
- a lack of standardization in the stock codes, with products registered under a same stock code with variations of the description
- misspellings
- products registered under the wrong stock code
- lack of standardization in the comments ('damage', 'damages', 'wet', 'rusty/wet')
- lack of clarity; identical products that varied by colour would have benefitted from being registered under the same stock code and inheriting an additional key for colour-coding

To approach the data cleaning, I selected all the stock codes that had multiple descriptions and listed the distinct descriptions per stock code.

Here are the cases I came across:

- <b>Stock code as description</b>
  <br>Sometimes the description indicated a stock code, which meant I had to edit the stock code and assign the correct description.
  <br>
  
- <b>Description is ambiguous in regards to adjacent rows</b>
<br>

![001 Ambiguous_names](https://github.com/user-attachments/assets/c4d05b88-3a53-453c-9a89-7ab9b40fac7d)

Inspecting the unit price should help. However, in this case it does not. This is probably due to multiple factors such as wholesale vs. retail, annual price variations and negotiated wholesail prices between the company and clients.
<br>

![002 AN_price doesnt help](https://github.com/user-attachments/assets/65e03a9d-55b6-4fc8-b3b9-f46db0306c0a)

- <b>Varying description for identical products</b>
<br>

![003 retrospotpolkadot](https://github.com/user-attachments/assets/c51b8913-6f8e-4dc7-b8b1-ede238ac382c)

'Polkadot' and 'retrospot' were used multiple times for one another. Again, this displays a lack of standardization.

- <b>Poor data entry</b>
<br>

![004 Poordataentry](https://github.com/user-attachments/assets/89e5d39d-b03c-48e5-a058-f45ecab4fbe7)
![005 Wobbly](https://github.com/user-attachments/assets/2732a8c3-9d68-4e11-a084-1a2f0be764d8)

### Assessing the impact of dropping the messy data all together

After cleaning part of the data, I calculated the total impact of this poor data on the whole dataset in order to assess if dropping it all together represents a severe impact on the quality of the dataset.

Step 1: Create a table that contains only the stockcodes with multiple descriptions

![006 01 MD_Step1](https://github.com/user-attachments/assets/d7f2ef68-560e-4018-b6f7-8ad26aa90260)

Step 2: asses the benefit/loss compared to the rest of the data
<br> Invoice numbers that start with the letter 'C' refer to orders that were cancelled; this is often due to a product that is out of stock, leading to a total loss of a potential income.
<br> By querying the dataset to assess the loss versus the profits, removing the poor records represents 3.17% of the cancelled orders and 2.93% of the effective orders.
<br> The analysis will be performed on the data that has been preserved after removal of the lower quality records.

## 2. Sales analysis

After dropping the messy data, we can now perform the analysis.
The time period of this dataset is of 12 months. The query returns 35 distinct countries; upon further inspection, two of them are labeled as 'Unspecified' and 'European Community'. These two labels are connected to 97 rows in total, which we will keep for now.
The company sells 3266 distinct items.

We will assess the sales from a global perspective, a monthly perspective, and a regional perspective.

### 2.1. Yearly analysis
