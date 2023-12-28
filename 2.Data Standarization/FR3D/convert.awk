BEGIN {print "chain1,resname1,resno1,chain2,resname2,resno2,type";}


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


NF==4 {
	split($1,first_res,"|");
	split($3,second_res,"|");
	if (first_res[2] == 1 && second_res[2] == 1 && first_res[5] < second_res[5])
		print first_res[3] "," first_res[4] "," first_res[5] "," second_res[3] "," second_res[4] "," second_res[5] "," get_type($2);
}
