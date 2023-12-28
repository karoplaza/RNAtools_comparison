function get_type(val) {
	if (length(val)==0)
		return val;
	else if (val == "WW_cis")
		return "cWW";
	else if (val == "WW_trans")
		return "tWW";
	else if (val == "HH_cis")
		return "cHH";
	else if (val == "HH_trans")
		return "tHH";
	else if (val == "SS_cis")
		return "cSS";
	else if (val == "SS_trans")
		return "tSS";
	else if (val == "SH_cis" || val == "HS_cis")
		return "cSH";
	else if (val == "SH_trans" || val == "HS_trans")
		return "tSH";
	else if (val == "SW_cis" || val == "WS_cis")
		return "cSW";
	else if (val == "SW_trans" || val == "WS_trans")
		return "tSW";
	else if (val == "HW_cis" ||  val == "WH_cis")
		return "cHW";
	else if (val == "HW_trans" || val == "WH_trans")
		return "tHW";
	else
		return "";
}

function get_id(field, resnames, which) {
	split(resnames, a, "-");
	split(field, b, "-");
	if (length(b)==2) {
		if (which == 1) {
			resname = a[1];
			chain_resno = b[1];
		} else {
			resname = a[2];
			chain_resno = b[2];
		}
	} else if (length(b)==4) {
		if (which == 1) {
			resname = a[1];
			chain_resno = b[1] "-" b[2];
		} else {
			resname = a[2];
			chain_resno = b[3] "-" b[4];
		}
	}
	if (index(chain_resno,"'")>0) {
		chain_resno = substr(chain_resno, index(chain_resno,"'")+1);
		thend = index(chain_resno,"'")
		chain = substr(chain_resno, 1, thend-1);
		resno =  substr(chain_resno, thend+1);
	} else {
		idx = match(chain_resno, /[-0-9]/);
		chain = substr(chain_resno, 0, idx-1);
		resno =  substr(chain_resno, idx);
	}
	return chain "," resname "," resno;
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
NF>=8 && $0 !~ /hbond/ {
split($4, inters, "/");
inter_id = substr(inters[1],0,1) substr(inters[2],0,1) "_" $(NF-1);
print get_id($1, $3, 1) ","  get_id($1, $3, 2) "," get_type(inter_id) "," get_saenger($NF);
}
NF>=8 && $0 ~ /hbond/ {
	if ((index($4,"/")>0) && (index($5,"/")==0)) {
		if ($NF == "one_hbond")
			ctidx = NF-1;
		else if ($(NF-1) == "one_hbond")
			ctidx = NF-2;
		split($4, inters, "/");
		inter_id = substr(inters[1],0,1) substr(inters[2],0,1) "_" $(ctidx);
		if (get_type(inter_id) != "")
			print get_id($1, $3, 1) ","  get_id($1, $3, 2) "," get_type(inter_id) ",,"
	}
}
