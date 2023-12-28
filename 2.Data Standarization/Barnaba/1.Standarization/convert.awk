BEGIN {print "chain1,resname1,resno1,chain2,resname2,resno2,type";} 

function get_type(val) {
	if (length(val)==0)
		return val;
	else if (val == "WCc" || val == "WWc" || val == "GUc")
		return "cWW";
	else if (val == "WWt")
		return "tWW";	
	else if (val == "HHc")
		return "cHH";
	else if (val == "HHt")
		return "tHH";
	else if (val == "SSc")
		return "cSS";
	else if (val == "SSt")
		return "tSS";
	else if (val == "SHc" || val == "HSc")
		return "cSH";
	else if (val == "SHt" || val == "HSt")
		return "tSH";
	else if (val == "SWc" || val == "WSc")
		return "cSW";
	else if (val == "SWt" || val == "WSt")
		return "tSW";
	else if (val == "HWc" || val == "WHc")
		return "cHW";
	else if (val == "HWt" || val == "WHt")
		return "tHW";
	else if (val == "XXX")
		return "XXX";
	else
		return "";
		}
		 

(NF==3) {
	split($1,first_res,"_");
	split($2,second_res,"_");
	print first_res[3] "," first_res[1] "," first_res[2] "," second_res[3] "," second_res[1] "," second_res[2] "," get_type($3);
}





