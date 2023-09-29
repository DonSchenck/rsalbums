use rsalbums;
SELECT * FROM rsalbums;
SELECT * FROM rsalbumstracks;
SELECT * FROM rsalbums JOIN rsalbumstracks ON rsalbums.albumID = rsalbumstracks.albumID;
go