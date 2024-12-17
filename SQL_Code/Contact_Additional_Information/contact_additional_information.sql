/* 
	This query returns additional information from a table containing a full name and an email address column.
*/



-- Table variable with columns for name and e-mail.
DECLARE @contact TABLE (
	name VARCHAR(50) -- Full name of a contact.
	,e_mail VARCHAR(50) -- Contacts email adress.
)



-- Inserting values into the table variable.
INSERT INTO @contact
VALUES 
	('Max Mustermann', 'max_mustermann@gmx.de')
	,('Anna Musterfrau', 'anna_musterfrau@gmxtgp.aut')
	,('Jakob Wiese', 'wiese.jakob@25pd.ok')
	,('Peter Smith', 'agent-sith@mail.op')



DECLARE @contact_additional_information TABLE (
	name VARCHAR(50) -- Full name of contact.
	,first_name VARCHAR(50) -- First name of contact.
	,surname VARCHAR(50) -- Surname of contact.
	,first_name_length INT -- Number of letters in the first name.
	,first_name_length_parity VARCHAR(4) -- Parity of the length of the first name.
	,surname_length INT -- Number of letters in the surname.
	,surname_length_parity VARCHAR(4) -- Parity of the length of the surname.
	,name_length INT -- Number of letters in the full name.
	,name_length_parity VARCHAR(4) -- Parity of the length of the full name.
	,first_letter_first_name CHAR(1) -- The first letter of the first name.
	,first_letter_surname CHAR(1) -- The first letter of the surname.
	,first_letters_matching VARCHAR(5) -- True if the first letter of the first name matches the first letter of the surname; otherwise, false.
	,e_mail VARCHAR(50) -- E-mail of a contact.
	,e_mail_front_part VARCHAR(50) -- All characters before the "@" in the email of the contact.
	,e_mail_last_part VARCHAR(50) -- All characters after the "@" in the email of the contact.
	,e_mail_provider VARCHAR(50) -- E-Mail provider.
	,e_mail_domain VARCHAR(50) -- E-Mail domain.
	,e_mail_length INT -- Number of characters in the email.
	,e_mail_provider_length INT -- Number of characters in the email provider.
	,e_mail_domain_length INT -- Number of characters in the email domain.
	,first_name_in_e_mail VARCHAR(5) -- True if the first name occurs in the email, otherwise false.
	,surname_in_e_mail VARCHAR(5) -- True if the surname occurs in the email, otherwise false.
	,name_in_e_mail VARCHAR(5) -- True if the full name occurs in the email, otherwise false.
)



INSERT INTO @contact_additional_information
SELECT 
	[name]
	,SUBSTRING([name], 1, CHARINDEX(' ', [name]) - 1)  -- Returns the characters from the beginning of the name up to the first whitespace.
	,SUBSTRING([name], CHARINDEX(' ', [name]) + 1, LEN([name])) -- Returns the characters after the whitespace in the name.
	,LEN(SUBSTRING([name], 1, CHARINDEX(' ', [name]) - 1)) -- Takes the code for the first name string and returns its length.
	,CASE	
		WHEN LEN(SUBSTRING([name], 1, CHARINDEX(' ', [name]) - 1)) % 2 = 0 THEN 'even'
		ELSE 'odd'
	END -- Takes the code of the length of the first name string and returns whether the length is even or odd.
	,LEN(SUBSTRING([name], CHARINDEX(' ', [name]) + 1, LEN([name]))) -- Takes the code for the surname string and returns its length.
	,CASE	
		WHEN LEN(SUBSTRING([name], CHARINDEX(' ', [name]) + 1, LEN([name]))) % 2 = 0 THEN 'even'
		ELSE 'odd'
	END -- Takes the code of the length of the surname string and returns whether the length is even or odd.
	,LEN(SUBSTRING([name], 1, CHARINDEX(' ', [name]) - 1)) + LEN(SUBSTRING([name], CHARINDEX(' ', [name]) + 1, LEN([name])))
	,CASE	
		WHEN (LEN(SUBSTRING([name], 1, CHARINDEX(' ', [name]) - 1)) + LEN(SUBSTRING([name], CHARINDEX(' ', [name]) + 1, LEN([name])))) % 2 = 0 THEN 'even'
		ELSE 'odd'
	END
	,SUBSTRING(SUBSTRING([name], 1, CHARINDEX(' ', [name]) - 1), 1, 1)
	,SUBSTRING(SUBSTRING([name], CHARINDEX(' ', [name]) + 1, LEN([name])), 1, 1)
	,CASE
		WHEN SUBSTRING(SUBSTRING([name], 1, CHARINDEX(' ', [name]) - 1), 1, 1) = SUBSTRING(SUBSTRING([name], CHARINDEX(' ', [name]) + 1, LEN([name])), 1, 1) THEN 'True'
		ELSE 'False'
	END
	,[e_mail]
	,SUBSTRING([e_mail], 1, CHARINDEX('@', [e_mail]) - 1)
	,SUBSTRING([e_mail], CHARINDEX('@', [e_mail]), LEN([e_mail]))
	,SUBSTRING(SUBSTRING([e_mail], CHARINDEX('@', [e_mail]), LEN([e_mail])), 2, CHARINDEX('.', SUBSTRING([e_mail], CHARINDEX('@', [e_mail]), LEN([e_mail]))) - 2) 
	,REVERSE(SUBSTRING(REVERSE([e_mail]), 1, CHARINDEX('.', REVERSE([e_mail])) - 1))
	,LEN([e_mail])
	,LEN(SUBSTRING(SUBSTRING([e_mail], CHARINDEX('@', [e_mail]), LEN([e_mail])), 2, CHARINDEX('.', SUBSTRING([e_mail], CHARINDEX('@', [e_mail]), LEN([e_mail]))) - 2))
	,LEN(REVERSE(SUBSTRING(REVERSE([e_mail]), 1, CHARINDEX('.', REVERSE([e_mail])) - 1)))
	,CASE	
		WHEN SUBSTRING([e_mail], 1, CHARINDEX('@', [e_mail]) - 1) LIKE '%' + SUBSTRING([name], 1, CHARINDEX(' ', [name]) - 1) + '%' THEN 'True'
		ELSE 'False'
	END -- Checks if the first name string is contained in the email.
	,CASE	
		WHEN SUBSTRING([e_mail], 1, CHARINDEX('@', [e_mail]) - 1) LIKE '%' + SUBSTRING([name], CHARINDEX(' ', [name]) + 1, LEN([name])) + '%' THEN 'True'
		ELSE 'False'
	END -- Checks if the surname string is contained in the email.
	,CASE	
		WHEN SUBSTRING([e_mail], 1, CHARINDEX('@', [e_mail]) - 1) LIKE '%' + SUBSTRING([name], 1, CHARINDEX(' ', [name]) - 1) + '%' + SUBSTRING([name], CHARINDEX(' ', [name]) + 1, LEN([name])) + '%' THEN 'True'
		WHEN SUBSTRING([e_mail], 1, CHARINDEX('@', [e_mail]) - 1) LIKE '%' + SUBSTRING([name], CHARINDEX(' ', [name]) + 1, LEN([name])) + '%' + SUBSTRING([name], 1, CHARINDEX(' ', [name]) - 1) + '%' THEN 'True'
		ELSE 'False'
	END -- Checks if the full name is contained in the email.
FROM @contact



SELECT *
FROM @contact_additional_information