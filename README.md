
## Create MariaDB Persistent database

`oc new-app --template=mariadb-persistent --param DATABASE_SERVICE_NAME=rsalbums --param MYSQL_USER=rsalbums --param MYSQL_PASSWORD=rsalbums --param MYSQL_DATABASE=rsalbums --param MYSQL_ROOT_PASSWORD=rsalbums`

## Get name of pod into environment variable
### PowerShell
`(kubectl get pods | select-string '^rsalbums([^\s]+)-(?!deploy)') -match 'rsalbums([^\s]+)'; $podname = $matches[0]`



## Upload file(s) to create and populate table(s)
### PowerShell
`oc cp .\create_table_rsalbums.sql ${podname}:/tmp/create_table_rsalbums.sql`  

`oc cp .\create_table_rsalbumstracks.sql ${podname}:/tmp/create_table_rsalbumstracks.sql`  

`oc cp .\create_table_rsalbums.sh ${podname}:/tmp/create_table_rsalbums.sh`  

`oc cp .\create_table_rsalbumstracks.sh ${podname}:/tmp/create_tablersalbums_tracks.sh`  

`oc cp .\rsalbums.csv ${podname}:/tmp/rsalbums.csv`

`oc cp .\rsalbumstracks.csv ${podname}:/tmp/rsalbumstracks.csv`

`oc cp .\populate_table_rsalbums_POWERSHELL.sql ${podname}:/tmp/populate_table_rsalbums_POWERSHELL.sql`

`oc cp .\populate_table_rsalbums_POWERSHELL.sh ${podname}:/tmp/populate_table_rsalbums_POWERSHELL.sh`

#### Execute command(s) in pod to create table(s)
`oc exec ${podname} -- /bin/bash /tmp/create_table_rsalbums.sh`
`oc exec ${podname} -- /bin/bash /tmp/create_table_rsalbumstracks.sh`

`oc exec ${podname} -- /bin/bash /tmp/populate_table_rsalbums_POWERSHELL.sh`


`oc exec ${podname} -- /bin/bash /tmp/populate_table_rsalbums_POWERSHELL.sh`

`oc cp .\populate_table_rsalbumstracks_POWERSHELL.sql ${podname}:/tmp/populate_table_rsalbumstracks_POWERSHELL.sql`

`oc cp .\populate_table_rsalbumstracks_POWERSHELL.sh ${podname}:/tmp/populate_table_rsalbumstracks_POWERSHELL.sh`

`oc exec ${podname} -- /bin/bash /tmp/populate_table_rsalbumstracks_POWERSHELL.sh`

`oc cp .\proof_query.sql ${podname}:/tmp/proof_query.sql`

`oc cp .\proof_query.sh ${podname}:/tmp/proof_query.sh`

`oc exec ${podname} -- /bin/bash /tmp/proof_query.sh`




#### Upload JSON file (cotaining data) to pod

#### Import data into database tables

#### Run query to prove success