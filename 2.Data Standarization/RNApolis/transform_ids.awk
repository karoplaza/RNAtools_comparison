function get_id(field) {
	split(field, a, ".");
	result = a[1] ",";
	idx = match(a[2], /[-0-9]/);
	resname = substr(a[2], 0, idx-1);
	resno =  substr(a[2], idx);
	result = result resname "," resno;
	return result;
}

function get_saenger(val) {
	if (length(val)==0)
		return val;
	else if (val == "I")
		return 1;
	else if (val == "II")
		return 2;
	else if (val == "III")
		return 3;
	else if (val == "IV")
		return 4;
	else if (val == "V")
		return 5;
	else if (val == "VI")
		return 6;
	else if (val == "VII")
		return 7;
	else if (val == "VIII")
		return 8;
	else if (val == "IX")
		return 9;
	else if (val == "X")
		return 10;
	else if (val == "XI")
		return 11;
	else if (val == "XII")
		return 12;
	else if (val == "XIII")
		return 13;
	else if (val == "XIV")
		return 14;
	else if (val == "XV")
		return 15;
	else if (val == "XVI")
		return 16;
	else if (val == "XVII")
		return 17;
	else if (val == "XVIII")
		return 18;
	else if (val == "XIX")
		return 19;
	else if (val == "XX")
		return 20;
	else if (val == "XXI")
		return 21;
	else if (val == "XXII")
		return 22;
	else if (val == "XXIII")
		return 23;
	else if (val == "XXIV")
		return 24;
	else if (val == "XXV")
		return 25;
	else if (val == "XXVI")
		return 26;
	else if (val == "XXVII")
		return 27;
	else if (val == "XXVIII")
		return 28;
	else
		return "";
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


BEGIN {print "chain1,resname1,resno1,chain2,resname2,resno2,type,saenger"; FS=",";}

NR > 1 {
	print get_id($1) "," get_id($2) "," get_type($3) "," get_saenger($4);
}
