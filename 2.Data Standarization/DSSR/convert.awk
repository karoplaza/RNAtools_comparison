function get_id(field) {
	split(field, a, ".");
	result = a[1] ",";
	idx = match(a[2], /[-0-9]/);
	resname = substr(a[2], 0, idx-1);
	resno =  substr(a[2], idx);
	result = result resname "," resno;
	return result;
}

function get_type(val) {
	if (length(val)==0)
		return val;
	else if (val == "cWW")
		return "cWW";
	else if (val == "tWW")
		return "tWW";
	else if (val == "cHH")
		return "cHH";
	else if (val == "tHH")
		return "tHH";
	else if (val == "cSS")
		return "cSS";
	else if (val == "tSS")
		return "tSS";
	else if (val == "cSH" || val == "cHS")
		return "cSH";
	else if (val == "tSH" || val == "tHS")
		return "tSH";
	else if (val == "cSW" || val == "cWS")
		return "cSW";
	else if (val == "tWS" || val == "tSW")
		return "tSW";
	else if (val == "cHW" ||  val == "cWH")
		return "cHW";
	else if (val == "tHW" || val == "tWH")
		return "tHW";
	else
		return "";
		}
		
BEGIN {print "chain1,resname1,resno1,chain2,resname2,resno2,type,saenger";}
$1 == "List" && $2 == "of" && $4 == "base" && $5 == "pairs" {b=1;}
#b == 1 && NF == 8 && $6 != "n/a" {
b == 1 && NF == 8 {
	split($6, elems, "-");
	if (get_type($7) != "")
		if ($6 != "n/a")
			print get_id($2) "," get_id($3) "," get_type($7) "," int(elems[1]);
		else
			print get_id($2) "," get_id($3) "," get_type($7) ",,";
}
$0 ~ /[\*]+/ {b=0;}
