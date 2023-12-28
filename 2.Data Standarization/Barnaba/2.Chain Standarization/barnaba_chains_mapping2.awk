BEGIN {
	alph = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z"
	split(alph,talph,",");
}
{
	a=substr($0,1,index($0,".")-1);
	split(a,b,"_");
	split(b[length(b)],c,"-");
	for(i=1;i<=length(c);i++)
		if ((length(c[i])==1) && (u==0))
			print i-1 "," c[i];
		else
			print i-1 "," talph[i];
}