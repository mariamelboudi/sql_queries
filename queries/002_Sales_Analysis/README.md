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

We will assess the sales from a global perspective, a monthly perspective, and a regional perspective. [Work in progress]

### 2.1. Yearly analysis

#### Yearly overview
![02 01 01 Gainloss](https://github.com/user-attachments/assets/c0e8bc62-da90-45e8-9bc8-6ecaa1fbba7b)

During this time period, the company generated 3,081,439.70£ and lost a potential 802,486.52£ in sales. This represents 26% of the total yearly revenue.

#### Item assessment
The monthly frequently sold item is the "REGENCY CAKESTAND 3 TIER"; it was sold 726 times and generated 64,513.86£.
The most revenue-generating item is the 'PAPER CRAFT, LITTLE BIRDIE' for 168,469.60£.

#### Client assessment
There are 3090 distinct customers.
<br>Customer n° 12748.0 ordered 130 times over the year. This is the sum of 118 effective orders and 12 cancelled orders, resulting in a positive revenue of 10,052.58£ and a loss of 3,326.28£.

![02 01 02 TOP5](https://github.com/user-attachments/assets/789092b7-ee18-4885-88d5-8cd34fee5349)

The five top buyers generated a total revenue of 627,272.86£, which represents 20% of the total revenu generated across this period.

The item the most frequently out of stock is an articled listed under the 'Manual'. It was out of stock 238 times, generating a total loss of 146,732.22£.

Amazon Fees were what cost the company the most over the year, with a spending of 235,281.59£.

### 2.2. Monthly analysis

Most popular item each month

![02 02 01Topmonthly](https://github.com/user-attachments/assets/06eab385-0dba-4b07-8f85-cef87ac51514)

Monthly revenue, losses and deltas

![02 02 03Lostvalues](https://github.com/user-attachments/assets/e5b7e049-60ff-44e2-8985-0be0e75177f2)
<br>Lowest sales: August 2011, 143,421.80£
<br>Highest sales: September 2011, 291,653.10£
<br>Lowest loss: April 2011, -21,012.28£
<br>Highest loss: December 2011, -202,970.85£

Object most often out of stock each month and value of missed sale:

![02 02 04MonthlyOOSvalues](https://github.com/user-attachments/assets/e5c8c166-378c-4df8-b40c-cc0b2bd23b81)

Causes for highest loss each month

![02 02 05Monthlyhighestloss](https://github.com/user-attachments/assets/e8e6b322-c82f-4bd6-a636-a16b4b242844)

### 2.3. Regional analysis

Top five countries and yearly revenue. Total = 2,936,421.08£ which represents 95.29% of the total generated revenue.

![02 03 01 TOP5COUNTRIES](https://github.com/user-attachments/assets/7430fa97-9eff-41b7-b920-a802f5b69f82)

Favourite article for these countries and revenue generated

![02 03 02 Toparticleper5country](https://github.com/user-attachments/assets/a2ff20be-edf8-49f2-9519-c361df99e36b)

Most revenue-generating article for these countries

![02 03 03 Toprevenuegeneratingarticle](https://github.com/user-attachments/assets/d8d82a49-e60f-45e9-8185-5013e28b8c1f)

Top five revenue-generating articles for top five countries.
![02 03 04Top5Top5](https://github.com/user-attachments/assets/024e5628-8b4f-49c0-a529-a559a6424966)

Revenu-loss variation (excerpt) for top 5 countries

![02 03 04 Monthlyrevenuetop5excerpt](https://github.com/user-attachments/assets/96d5b1b8-b827-4bab-a635-489800c53ab7)

The only country that has spent revenue on Amazon Fees is the UK. This equates to an overall expenditure of 221,520.50£. This is a net loss of 7.18% throughout the year.

![02 03 06AmazonFees](https://github.com/user-attachments/assets/9fc0bcb5-a3a2-4190-9cfa-7ebced9496d9)

## 3. Assessment

The overall revenue generated by this company is impeded by cancelled orders and high amazon fees.
<br>
<br>Making sure that stocks are available and sufficient for high-volume orders all-year around would allow it to increase further revenue. Indeed, lost sales accounted for 25% of the total revenue, which is a high number.
<br>
<br>When querying the table to inspect the customer id linked to 'AMAZON FEE', the table returns null values. This might be due to privacy regulations on Amazon's side.
<br>
<br>Querying all the invoice numbers where the description is 'AMAZON FEE' returns 34 distinct invoice numbers, all starting with the letter 'C', except for two. As a reminder, invoice numbers starting with the letter 'C' stand for cancelled orders. It appears that a particular item was only restocked twice before being shortly out of stock, as shown in the time frame below.

![03 01 AMAZONFEE](https://github.com/user-attachments/assets/f5b29e31-1a71-41c6-b43a-ed7e5871e5da)

Additionally, the company would greatly benefit from investing in repairs for their warehouse. A non-negligeable percentage of items were registered as 'damaged', 'rusty', 'damaged/rusty', resulting in further loss.
