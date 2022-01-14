/**********************************/
/* Table Name: 주택 정보 */
/**********************************/
CREATE TABLE houseinfo(
		houseno INT NOT NULL PRIMARY KEY,
		nomination VARCHAR(30) NOT NULL,
		area DOUBLE NOT NULL,
		terrain VARCHAR(30) NOT NULL,
		price INT NOT NULL,
		date DATETIME NOT NULL,
		like INT NOT NULL
);

