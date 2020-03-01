#!/bin/bash
sudo -v
function typeSeparator {
sudo rm -rf /tmp/*.txt 2>/dev/null
for server in $(<ips.sorted); do
	APISTATS=$(echo -n "stats" | nc -w 1 $server 4028 | tr -d '\0')
	DESCR=$(echo $APISTATS | sed -e 's/,/\n/g' | grep "Description" | cut -d "=" -f2)
	BM="bm"
	SG="sg"
	CG="cg"
	if [[ $DESCR = $BM* ]]; then
		echo "$server" | tee -a /tmp/bmMiner.txt
	elif [[ $DESCR = $SG* ]]; then 
		echo "$server" | tee -a /tmp/sgMiner.txt
	elif [[ $DESCR = $CG* ]]; then 
		echo "$server" | tee -a /tmp/cgMiner.txt
	else
		echo "$server is NOT a miner" | tee -a /tmp/notMiner.txt
	fi
done
}
function scanner {
#### scan network then use shit above
if [ -z ${1+x} ]; then ## if no subnet range was provided, use defaults
        echo "Starting To Scan 10.2.1.1/22 Range"
	fping -a -g 10.2.1.1/22 2>/dev/null > results.csv
else
        echo "Starting To Scan $1 Range"
	fping -a -g $1 2>/dev/null > results.csv
fi
echo "Finished Scan, Checking Miner Types"
sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 results.csv > ips.sorted
rm -rf results.csv
}
function getData {
for server2 in $(<$1); do
	total=0    #per shelf total for ending at 24 miners per rack
	APISTATS=$(echo -n "stats" | nc -w 1 $server2 4028 | tr -d '\0')
	DESCR=$(echo $APISTATS | sed -e 's/,/\n/g' | grep "Description" | cut -d "=" -f2)
	apistats=`echo -n "stats" | nc -w 1 $server2 4028 | tr -d '\0'`
	hashStats=$(echo -n "stats" | nc -w 1 $server2 4028 | tr -d '\0') ## had to add last tr part cuz of persistant warnings i couldnt redirect
	lessStats=$(echo -n "summary" | nc -w 1 $server2 4028 | tr -d '\0')
#	poolStats=`echo -n "pools" | nc $server2 4028 2>/dev/null`
	MHASHRATE=$(echo $apistats | sed -e 's/,/\n/g' | grep "MHS av" | cut -d "=" -f2)     
	GHASHRATE=$(echo $hashStats | sed -e 's/,/\n/g' | grep "GHS av" | cut -d "=" -f2)
	HASHRATE=`echo $apistats | sed -e 's/,/\n/g' | grep "GHS av" | cut -d "=" -f2`
	BLADECOUNT=`echo $apistats | sed -e 's/,/\n/g' | grep "miner_count=" | cut -d "=" -f2`
	POOLS=`echo $apiStats | sed -e 's/,/\n/g' | grep "URL" | cut -d "=" -f2`
	TYPE=`echo $apiStats | sed -e 's/,/\n/g' | grep "Description" | cut -d "=" -f2`
	mType=$2
	gHASHRATE=$(bc -l <<< "$HASHRATE/1000")
	hashes=$(echo $gHASHRATE | head -c 4)
	### echo -n "gpurestart|1" will restart gpu 1!!	## in DEVS: Msg=6 GPU(s)
	if [[ "$BLADECOUNT" -lt "3" ]]; then
		LOW="LOW HASHRATE -- 1 OR MORE CARDS DOWN"
	else
		LOW=""
	fi
	pos=$(./grabPositionValue.sh $arrayNum) # 1-1-1-1
	ipVar="10.$container.$rack.$rackTotal" # 10.x.x.x
	mac=$(./macFromIp.sh $server2)
	if [ -z ${mac+x} ]; then
		echo "$server Is Causing Problems" | tee -a /tmp/notMiner.txt
		continue
	fi
	farm=$(./grabSiteName.sh)      ### USED TO BE HARDCODED, MEBBE BUGGY
	temps=$(./tempsApi.sh $server2 | head -n 1)		
	echo "mac is $mac"
	echo "ghash $GHASHRATE mhash $MHASHRATE gHASH is $gHASHRATE"
	echo "server is set to $server2"
	echo "pos set to $pos"
	echo "type is $mType"
	
	###################################################3
	
	echo "farmName is $farm"
	echo "numCards is $numCards"                     #Grab These DataPoints!!!!
	echo "uptime is $uptime"
	echo "poolUser is $poolUser"

	###################################################3

	devServer="http://zoomhash.us"
	addString="curl 'http://zoomhash.us/add.php' -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' -H 'Origin: http://zoomhash.us' -H 'Upgrade-Insecure-Requests: 1' -H 'Content-Type: application/x-www-form-urlencoded' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Referer: http://zoomhash.us/add.php' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.9,es-419;q=0.8,es;q=0.7,ru;q=0.6'" 
	
	###################################################3#################################################
	#  Need to make my update script grab the uid from database then use the minerID to update values...#
	#####################################################################################################

### THis one from the old jquery monitor...
	jqueryString="curl 'http://zoomhash.ddns.net/create.php' -H 'Cookie: PHPSESSID=g4ugbmd6hcte86lo72iain8prt' -H 'Origin: http://zoomhash.ddns.net' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9,es-419;q=0.8,es;q=0.7,ru;q=0.6' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded; charset=UTF-8' -H 'Accept: */*' -H 'Referer: http://zoomhash.ddns.net/index.php' -H 'X-Requested-With: XMLHttpRequest' -H 'Connection: keep-alive'"
 	dataString="--data 'minerIp=$server2&macAddress=$mac&minerType=$mType&plocation=$pos&hashrate=$GHASHRATE&maxTemp=$temps&farmName=$farm&numCards=$numCards&uptime=$uptime&poolUser=$poolUser&comments=empty&Submit=Add' --compressed"
	shortDataString"--data 'minerIp=$server2&macAddress=$mac&minerType=$mType&plocation=$pos&hashrate=$GHASHRATE&Submit=Add' --compressed"
	updateStartString="curl 'http://zoomhash.us/edit.php' -H 'Connection: keep-alive' -H 'Cache-Control: max-age=0' -H 'Origin: http://zoomhash.us' -H 'Upgrade-Insecure-Requests: 1' -H 'Content-Type: application/x-www-form-urlencoded' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.181 Safari/537.36' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Referer: http://zoomhash.us/edit.php?id=1' -H 'Accept-Encoding: gzip, deflate' -H 'Accept-Language: en-US,en;q=0.9,es-419;q=0.8,es;q=0.7,ru;q=0.6'"
	updateEndString="--data 'minerIp=XXX&macAddress=XXX&minerType=XXX&plocation=XXX&hashrate=XXX&maxTemp=XXX&plocation=XXX&hashrate=XXX&maxTemp=XXX&comments=XXX&comments=XXX&id=1&update=Update' --compressed"
	endString="--data 'minerIp=$server2&macAddress=$mac&minerType=$mType&plocation=$pos&hashrate=$GHASHRATE&maxTemp=$temps&farmName=$farm&numCards=XXX&uptime=XXX&poolUser=XXX&comments=empty&Submit=Add' --compressed"
	newString="curl '$devServer/add.php' -H 'Cookie: PHPSESSID=g4ugbmd6hcte86lo72iain8prt' -H 'Origin: $devServer' -H 'Accept-Encoding: gzip, deflate, br' -H 'Accept-Language: en-US,en;q=0.9,es-419;q=0.8,es;q=0.7,ru;q=0.6' -H 'Upgrade-Insecure-Requests: 1' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/65.0.3325.181 Safari/537.36' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8' -H 'Cache-Control: max-age=0' -H 'Referer: $devServer/add.php' -H 'Connection: keep-alive' --data 'minerIp=$server2&macAddress=$mac&minerType=$mType&plocation=$pos&hashrate=$GHASHRATE&maxTemp=$temps&Submit=Add' --compressed"
	concat="$jqueryString $shortDataString"
	eval $(echo $concat)
	let "rackTotal+=1"
	let "total+=1"
	let "arrayNum+=1"
done
}
arrayNum=0
scanner
typeSeparator
getData /tmp/sgMiner.txt "GpuMiner"
getData /tmp/bmMiner.txt "AntMiner S9"
getData /tmp/cgMiner.txt "AntMiner L3"
exit 1
