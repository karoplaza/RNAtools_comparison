function get_idx(fields, name) {
	for(i in fields)
		if (index(fields[i], name)>0)
			return i;
	return -1;
}

BEGIN {print "chain1,resname1,resno1,chain2,resname2,resno2,saenger";}
start == 1 && $0~/^_ndb_struct_na_base_pair\./ {fields[++idx] = $0;}
start == 0 && $0~/^_ndb_struct_na_base_pair\./ {fields[++idx] = $0; start=1;}
start == 1 && $0!~/^_ndb_struct_na_base_pair\./ {
	if (NF == idx) {
		modelno = $get_idx(fields, "model_number");
		if (modelno == 1) {
			first_chain = $get_idx(fields, "i_auth_asym_id");
			first_resname = $get_idx(fields, "i_label_comp_id");
			first_resno = $get_idx(fields, "i_auth_seq_id");
			second_chain = $get_idx(fields, "j_auth_asym_id");
			second_resname = $get_idx(fields, "j_label_comp_id");
			second_resno = $get_idx(fields, "j_auth_seq_id");
			saenger = $get_idx(fields, "hbond_type_28");
			if (saenger != "?")
				print first_chain "," first_resname "," first_resno "," second_chain "," second_resname "," second_resno "," saenger;
		}
	}
}
$0~/#/ {start = 0;}
