CREATE DATABASE IF NOT EXISTS bank;
USE bank;

/* Load Account */

CREATE TABLE IF NOT EXISTS Account(
	account_id INT,
    district_id INT,
    frequency VARCHAR(20),
    `date` DATE
);

LOAD DATA LOCAL
INFILE '~/Documents/DataScience/ds_projects/loan_default_prediction/data/account.asc'
INTO TABLE Account
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(account_id, district_id, frequency, @c4)
SET `date` = STR_TO_DATE(@c4, '%y%m%d');

/* Load Client */

CREATE TABLE IF NOT EXISTS Client(
	client_id INT,
	gender VARCHAR(10),
	birth_date DATE,
	district_id INT
);

LOAD DATA LOCAL
INFILE '~/Documents/DataScience/ds_projects/loan_default_prediction/data/client.asc'
INTO TABLE Client
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(client_id, @c2, district_id)
SET gender = if(SUBSTR(@c2, 3, 2) > 50, 'female', 'male'),
birth_date = if(SUBSTR(@c2, 3, 2) > 50, 
	CONCAT_WS('-', CONCAT('19', SUBSTR(@c2, 1, 2)), SUBSTR(@c2, 3, 2) - 50, SUBSTR(@c2, 5, 2)),
	STR_TO_DATE(CONCAT('19', @c2), '%Y%m%d'));

/* Load Disposition */

CREATE TABLE IF NOT EXISTS Disposition(
	disp_id INT,
	client_id INT,
	account_id INT,
	type VARCHAR(20)
);

LOAD DATA LOCAL
INFILE '~/Documents/DataScience/ds_projects/loan_default_prediction/data/disp.asc'
INTO TABLE Disposition
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

/* Load Order */

CREATE TABLE IF NOT EXISTS `Order`(
	order_id INT,
	account_id INT,
	bank_to VARCHAR(5),
	account_to INT,
	amount DECIMAL(20, 2),
	k_symbol VARCHAR(20)
);

LOAD DATA LOCAL
INFILE '~/Documents/DataScience/ds_projects/loan_default_prediction/data/order.asc'
INTO TABLE `Order`
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

/* Load Trans */

CREATE TABLE IF NOT EXISTS Trans(
	trans_id INT,
	account_id INT,
	`date` DATE,
	type VARCHAR(20),
	operation VARCHAR(20),
	amount INT,
	balance INT,
	k_symbol VARCHAR(20),
	bank VARCHAR(20),
	account INT
);

LOAD DATA LOCAL
INFILE '~/Documents/DataScience/ds_projects/loan_default_prediction/data/trans.asc'
INTO TABLE Trans
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(trans_id, account_id, @c3, type, operation, amount, balance, k_symbol, bank, account)
SET `date` = STR_TO_DATE(@c3, '%y%m%d');

/* Load Loan */

CREATE TABLE IF NOT EXISTS Loan(
	loan_id INT,
	account_id INT,
	`date` DATE,
	amount INT,
	duration INT,
	payments DECIMAL(20, 2),
	status VARCHAR(10)
);

LOAD DATA LOCAL
INFILE '~/Documents/DataScience/ds_projects/loan_default_prediction/data/loan.asc'
INTO TABLE Loan
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

/* Load Credit Card */

CREATE TABLE IF NOT EXISTS Card(
	card_id INT,
	disp_id INT,
	type VARCHAR(20),
	issued DATE
);

LOAD DATA LOCAL
INFILE '~/Documents/DataScience/ds_projects/loan_default_prediction/data/card.asc'
INTO TABLE Card
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(card_id, disp_id, type, @c4)
SET issued = STR_TO_DATE(@c4, '%y%m%d %H:%i:%s');

/* Load District */

DROP TABLE IF EXISTS District;

CREATE TABLE IF NOT EXISTS District(
	district_id INT,
	A2 VARCHAR(20),
	A3 VARCHAR(20),
	A4 INT,
	A5 INT,
	A6 INT,
	A7 INT,
	A8 INT,
	A9 INT,
	A10 DECIMAL(10, 1),
	A11 INT,
	A12 DECIMAL(2, 2),
	A13 DECIMAL(2, 2),
	A14 INT,
	A15 INT,
	A16 INT
);

LOAD DATA LOCAL
INFILE '~/Documents/DataScience/ds_projects/loan_default_prediction/data/district.asc'
INTO TABLE District
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;



