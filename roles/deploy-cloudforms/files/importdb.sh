#!/usr/bin/env bash

version=45
dumpfile=$APPLIANCE_PG_DATA/vmdb_production_latest.dump
dumploc=http://10.9.62.89/dumps/$version/vmdb_production_latest.dump
passwd=smartvm
currdir=$PWD
pause_in_seconds=2

echo
echo "Execute: curl -o $dumpfile $dumploc"
date;read -t $pause_in_seconds -p "Press any key or wait $pause_in_seconds seconds";echo;date
curl -o $dumpfile $dumploc

echo
echo "Execute: systemctl stop evmserverd"
date;read -t $pause_in_seconds -p "Press any key or wait $pause_in_seconds seconds";echo;date
systemctl stop evmserverd

echo
echo "Execute: dropdb -e vmdb_production"
date;read -t $pause_in_seconds -p "Press any key or wait $pause_in_seconds seconds";echo;date
dropdb -e vmdb_production

echo
echo "Execute: createdb -e vmdb_production"
date;read -t $pause_in_seconds -p "Press any key or wait $pause_in_seconds seconds";echo;date
createdb -e vmdb_production

echo
echo "Execute: pg_restore -vd vmdb_production $dumpfile"
date;read -t $pause_in_seconds -p "Press any key or wait $pause_in_seconds seconds";echo;date
pg_restore -vd vmdb_production $dumpfile

echo changing directory to vmdb
cd /var/www/miq/vmdb

echo
echo "Execute: bundle exec tools/fix_auth.rb --v2 --invalid bogus"
date;read -t $pause_in_seconds -p "Press any key or wait $pause_in_seconds seconds";echo;date
bundle exec tools/fix_auth.rb --v2 --invalid bogus

echo
echo "Execute: bin/rails r 'User.find_by_userid('admin').update_attributes(:password => '$passwd')"
date;read -t $pause_in_seconds -p "Press any key or wait $pause_in_seconds seconds";echo;date
bin/rails r "User.find_by_userid('admin').update_attributes(:password => '$passwd')"

echo
echo "Execute: systemctl start evmserverd"
date;read -t $pause_in_seconds -p "Press any key or wait $pause_in_seconds seconds";echo;date
systemctl start evmserverd

cd $currdir
