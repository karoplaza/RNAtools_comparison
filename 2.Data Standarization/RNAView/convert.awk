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

BEGIN {print "chain1,resname1,resno1,chain2,resname2,resno2,type,saenger";}
$0 == "BEGIN_base-pair", $0 == "END_base-pair" {
	if (NF == 9 && $NF !~ /^!/) {
		split($4, elems, "-");
		if ($9 == "XIX" || $9 == "XX" || $9 == "XXVIII")
			print substr($2, 0, length($2)-1) "," elems[1] "," $3 "," substr($6, 0, length($6)-1) "," elems[2] "," $5 ",cWW," get_saenger($9);
		else {
			split($7, inters, "/");
			inter_id = inters[1] inters[2] "_" $8;
			print substr($2, 0, length($2)-1) "," elems[1] "," $3 "," substr($6, 0, length($6)-1) "," elems[2] "," $5 "," get_type(inter_id) "," get_saenger($9);
		}
	}
}
