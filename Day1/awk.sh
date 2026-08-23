awk '
BEGIN {
	printf "%-15s | %s\n", "IP Address", "Visits"
	printf "----------------|--------\n"
}
{
	visits[$1]++
}
END {
	for (ip in visits)
		printf "%-15s | %s\n", ip, visits[ip] | "sort -t \"|\" -k 2 -nr"
}
' server.log
