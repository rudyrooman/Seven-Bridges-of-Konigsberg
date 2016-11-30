set kruispunt;

param start symbolic in kruispunt;          
param einde symbolic in kruispunt;
set teller = 1..2 by 1; # soms zijn er 2 verbindingen tussen kamers

set straat within kruispunt cross kruispunt cross teller  ;

var Use {straat} integer >=0;

# voor elke straat (i,j) bestaat (j,i) de som van beiden is 1. slechts 1 richting gebruiken
s.t. c0{(i,j,r) in straat}: Use[i,j,r]+ Use[j,i,r]=1;


# aantal ingaande = aantal uitgaande 
s.t. c1{ k in kruispunt : k <> start and k <> einde }: 
	sum{(i,k,r) in straat } Use[i,k,r] = sum{(k,j,s) in straat} Use[k,j,s]; # alle kp die niet start en einde zijn
s.t. c1bis{ k in kruispunt : k = start and k = einde }: 
	sum{(i,k,r) in straat } Use[i,k,r] = sum{(k,j,s) in straat} Use[k,j,s]; # als start en einde zelfde punt zijn 

# bij de start aantal ingaande+1 = aantal uitgaande  
s.t. c2{ k in kruispunt : k = start and k <> einde}: 
	1+ sum{(i,k,r) in straat } Use[i,k,r] = sum{(k,j,s) in straat } Use[k,j,s];

# bij de aankomst aantal ingaande = aantal uitgaande +1 
s.t. c3{ k in kruispunt : k = einde and k <> start}: 
	sum{(i,k,r) in straat} Use[i,k,r] = 1+ sum{(k,j,s) in straat } Use[k,j,s];




           