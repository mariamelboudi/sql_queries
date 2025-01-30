When a name seems to be a mix of the previous and the following row.
![001 Ambiguous_names](https://github.com/user-attachments/assets/c4d05b88-3a53-453c-9a89-7ab9b40fac7d)

Inspecting the unit price should help.
However, in this case it does not.
![002 AN_price doesnt help](https://github.com/user-attachments/assets/65e03a9d-55b6-4fc8-b3b9-f46db0306c0a)

Encountered 'polkadot' and 'retrospot' multiple times. Now I understand that one is being used for the other.
Will standardise in the futur.

![003 retrospotpolkadot](https://github.com/user-attachments/assets/c51b8913-6f8e-4dc7-b8b1-ede238ac382c)


Checking the nearest rows reveals further poor data entry
![004 Poordataentry](https://github.com/user-attachments/assets/89e5d39d-b03c-48e5-a058-f45ecab4fbe7)

Here the names are a bit suprising. A few rows down there is a name that seems more standardised and representative.
![005 Wobbly](https://github.com/user-attachments/assets/2732a8c3-9d68-4e11-a084-1a2f0be764d8)

Alternatively, I could have calculated the total impact of this poor data on the whole dataset and dropped it all together if it represented a reasonable amount of loss.

### Assessing the impact of dropping the messy data all together
Step 1: Create a table that contains only the stockcodes with multiple descriptions

![006 01 MD_Step1](https://github.com/user-attachments/assets/d7f2ef68-560e-4018-b6f7-8ad26aa90260)

Step 2: asses the benefit/loss compared to the rest of the data

ADVICE
- standardise stock codes
- standardise dscription
- separate colours in a different column to achieve more granularity
- standardise optionale codes (damaged, etc)
- warehouse improvement: many damaged items were rusty

## 2. Sales analysis

After dropping the messy data, we can now perform the analysis.
The time period of this dataset is of 12 months. The query returns 35 distinct countries; upon further inspection, two of them are labeled as 'Unspecified' and 'European Community'. These two labels are connected to 97 rows in total, which we will keep for now.
The company sells 3266 distinct items.

We will assess the sales from a global perspective, a monthly perspective, and a regional perspective.

### 2.1. Yearly analysis
