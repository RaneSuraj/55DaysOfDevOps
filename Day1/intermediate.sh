: <<'COMMENT'
#!/bin/bash

set -euo pipefail # -e: exit immediately if any cmd fails, -u: unset variable treating as a error, -o pipefail: if any pipe cmd fail consider entire fail


greet (){
	echo "Hello, $1"
}

greet "Suraj Rane!"


servers=("app1", "app2", "web1", "web2", "db")
echo "Third element is: ${servers[2]}" #op --> web1
echo "Element present inside servers are: ${servers[@]}" #all elements printed
echo "Count of array elements: ${#servers[@]}" #count of array elements


for server in "${servers[@]}"; do
	echo "Checking $server"
done


#for ip in $(cat ip.txt); do
#	echo "Transfering file to $ip......"
#	echo "scp local_path username@$ip:/remote_location"
#done


file="server_log_file.txt"
echo "${file%.txt}" #truncates the string from last
echo "${file#server}" # truncates the string from start
echo "${file/server/database}" # replace value 
echo "${#file}" # length
COMMENT


echo "================ AWK ==================="
awk '{print $NR, $1, $NF}' system_activity.log

