BEGIN {FS=",";}
NR==1 
(NR>1) && ($NF == "cWW") && (($2 ~ /^G/ && $5 ~ /^C/) || ($2 ~ /^A/ && $5 ~ /^U/) || ($2 ~ /^G/ && $5 ~ /^U/) || ($2 ~ /^C/ && $5 ~ /^G/) || ($2 ~ /^U/ && $5 ~ /^A/) || ($2 ~ /^U/ && $5 ~ /^G/))