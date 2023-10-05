## Create MariaDB Persistent database
##oc new-app --template=mariadb-persistent --param DATABASE_SERVICE_NAME=rsalbums --param MYSQL_USER=rsalbums --param MYSQL_PASSWORD=rsalbums --param MYSQL_DATABASE=rsalbums --param MYSQL_ROOT_PASSWORD=rsalbums

echo 'Waiting for pod to be ready...'
Sleep 15

## Get name of pod into environment variable
export PODNAME=$(oc get pods -o custom-columns=POD:.metadata.name --no-headers | grep -v 'deploy$' | grep rsalbums)
echo $PODNAME

## Upload file(s) to create and populate table(s)
Write-Output "Copying files to pod"
oc cp .\create_table_rsalbums.sql $PODNAME:/tmp/create_table_rsalbums.sql
oc cp .\create_table_rsalbumstracks.sql $PODNAME:/tmp/create_table_rsalbumstracks.sql
oc cp .\create_table_rsalbums.sh $PODNAME:/tmp/create_table_rsalbums.sh
oc cp .\create_table_rsalbumstracks.sh $PODNAME:/tmp/create_table_rsalbumstracks.sh
oc cp .\rsalbums.csv $PODNAME:/tmp/rsalbums.csv
oc cp .\rsalbumstracks.csv $PODNAME:/tmp/rsalbumstracks.csv
oc cp .\populate_table_rsalbums_POWERSHELL.sql $PODNAME:/tmp/populate_table_rsalbums_POWERSHELL.sql
oc cp .\populate_table_rsalbums_POWERSHELL.sh $PODNAME:/tmp/populate_table_rsalbums_POWERSHELL.sh

#### Execute command(s) in pod to create table(s)
Write-Output "Creating tables"
oc exec $PODNAME -- /bin/bash /tmp/create_table_rsalbums.sh
oc exec $PODNAME -- /bin/bash /tmp/create_table_rsalbumstracks.sh
oc exec $PODNAME -- /bin/bash /tmp/populate_table_rsalbums_POWERSHELL.sh

Write-Output "Populating tables"
oc cp .\populate_table_rsalbumstracks_POWERSHELL.sql $PODNAME:/tmp/populate_table_rsalbumstracks_POWERSHELL.sql
oc cp .\populate_table_rsalbumstracks_POWERSHELL.sh $PODNAME:/tmp/populate_table_rsalbumstracks_POWERSHELL.sh
oc exec $PODNAME -- /bin/bash /tmp/populate_table_rsalbumstracks_POWERSHELL.sh

# Prove it
Write-Output "Proof query"
oc cp .\proof_query.sql $PODNAME:/tmp/proof_query.sql
oc cp .\proof_query.sh $PODNAME:/tmp/proof_query.sh
oc exec $PODNAME -- /bin/bash /tmp/proof_query.sh
