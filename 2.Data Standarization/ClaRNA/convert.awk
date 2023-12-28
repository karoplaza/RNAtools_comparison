function get_type(val) {
	if (length(val)==0)
		return val;
	else if (val == "WW_cis")
		return "cWW";
	else if (val == "WW_tran")
		return "tWW";
	else if (val == "HH_cis")
		return "cHH";
	else if (val == "HH_tran")
		return "tHH";
	else if (val == "SS_cis")
		return "cSS";
	else if (val == "SS_tran")
		return "tSS";
	else if (val == "SH_cis" || val == "HS_cis")
		return "cSH";
	else if (val == "SH_tran" || val == "HS_tran")
		return "tSH";
	else if (val == "SW_cis" || val == "WS_cis")
		return "cSW";
	else if (val == "SW_tran" || val == "WS_tran")
		return "tSW";
	else if (val == "HW_cis" ||  val == "WH_cis")
		return "cHW";
	else if (val == "HW_tran" || val == "WH_tran")
		return "tHW";
	else
		return "";
}

BEGIN {print "chain1,resname1,resno1,chain2,resname2,resno2,type";} 
NF == 9 {print $1 "," $6 "," $2 "," $3 "," $7 "," $4 "," get_type($8);}
