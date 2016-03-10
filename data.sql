

create table accession
(accession_number 	VARCHAR(8) 	NOT NULL,
organism 		VARCHAR(50) 	DEFAULT 'N/A' NOT NULL, 

PRIMARY KEY (accession_number)
);

LOAD DATA INFILE "/d/user6/rn002/biocomp2/data.csv" INTO TABLE accession
    FIELDS TERMINATED BY '='
    lINES TERMINATED BY '\n';

 


