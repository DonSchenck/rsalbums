USE rsalbums;
LOAD DATA INFILE '/tmp/rsalbumstracks.csv'
INTO TABLE rsalbumstracks
FIELDS TERMINATED BY '|'
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n';