![image](https://github.com/user-attachments/assets/83d30175-37a0-49ca-8f0a-6cae84e25ad7)

'A crime has taken place and the detective needs your help. The detective gave you the crime scene report, but you somehow lost it. You vaguely remember that the crime was a ​murder​ that occurred sometime on ​Jan.15, 2018​ and that it took place in ​SQL City​.'
[Source](https://mystery.knightlab.com/)

| Date       | Type   | Description                                                                                                   | Location  |
|------------|--------|---------------------------------------------------------------------------------------------------------------|-----------|
| 2018-01-15 | Murder | Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave". | SQL City  |

##### Witness n°1

| id    | name          | license_id | address_number| address_street_name | ssn        |
|-------|---------------|------------|---------------|---------------------|------------|
| 14887 | Morty Schapiro| 118009     | 4919          | Northwestern Dr     | 111564949  |

##### Witness n°2

| id    | name          | license_id | address_number| address_street_name | ssn        |
|-------|---------------|------------|---------------|---------------------|------------|
| 16371 | Annabel Miller| 490173     | 103           | Franklin Ave        | 318771143  |

##### Retrieved interview transcripts

| person_id | name           | transcript |
|-----------|----------------|------------|
| 14887     | Morty Schapiro | I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W". |
| 16371     | Annabel Miller | I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th. |

##### Gold memberships that were at the gym on January 9th

| check_in_date| name           |
|--------------|----------------|
| 2018-01-09   | Sarita Bartosh |
| 2018-01-09   | Burton Grippe  |
| 2018-01-09   | Carmen Dimick  |
| 2018-01-09   | Joe Germuska   |
| 2018-01-09   | Jeremy Bowers  |
| 2018-01-09   | Annabel Miller |

##### Connect the name to the plate number that includes 'H42W'

| check_in_date | name        | plate_number |
|--------------|--------------|--------------|
| 2018-01-09   | Jeremy Bowers| 0H42W2       |

##### Retrieve the interview transcript for Jeremy Bowers

| name          | transcript |
|---------------|------------|
| Jeremy Bowers | I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017. |
