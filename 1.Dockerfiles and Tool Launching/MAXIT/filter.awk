{a[NR]=$0;}
$0~/^loop_/	{b=NR;}
END {for(i=b;i<=NR;i++) print a[i];}