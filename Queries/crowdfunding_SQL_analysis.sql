SELECT * FROM backers
LIMIT 10;
SELECT * FROM campaign;






-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 

SELECT
	cf_id,
	backers_count AS backer_counts
FROM campaign
WHERE outcome = 'live'
ORDER BY backer_counts DESC;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.

SELECT
	ca.cf_id,
	COUNT(ba.first_name) as backer_counts
FROM campaign AS ca
LEFT JOIN backers as ba
ON ca.cf_id = ba.cf_id
WHERE ca.outcome = 'live'
GROUP BY 1
ORDER BY 2 DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 

SELECT
	co.first_name as "First Name",
	co.last_name as "Last Name",
	co.email as "Email",
	(ca.goal - ca.pledged) as "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM contacts as co
LEFT JOIN campaign as ca
ON ca.contact_id = co.contact_id
WHERE ca.outcome = 'live'
ORDER BY 4 DESC;



-- Check the table

SELECT * FROM email_contacts_remaining_goal_amount LIMIT 10;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 

DROP TABLE email_backers_remaining_goal_amount;
SELECT DISTINCT
	ba.email as "Email",
	ba.first_name as "First Name",
	ba.last_name as "Last Name",
	ba.cf_id,
	ca.company_name as "Company",
	ca.description as "Description",
	ca.end_date as "End Date",
	(ca.goal - ca.pledged) as "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM campaign as ca
LEFT JOIN backers as ba
ON ba.cf_id = ca.cf_id
WHERE ca.outcome = 'live'
ORDER BY 3;

-- Check the table

SELECT * FROM email_backers_remaining_goal_amount LIMIT 10;