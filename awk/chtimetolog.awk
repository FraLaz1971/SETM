#!/usr/bin/awk -f
BEGIN 	{FS="|"; OFS=","} 
/\|/	{ 
		#change time format
		split($1, dtp, ".")
		#print "dtp contains " length(dtp) "fields" > "/dev/stderr"
		#for (i=1; i<=length(dtp); i++) print dtp[i] " "
		printf("%s|",dtp[1])
		for (a=2; a<NF; a++) {
			printf("%s|",$a)
		} 
		printf("%s",$NF)
		printf("\n")
	} 
! /\|/ 	{}
END 	{print "changing time to file " FILENAME " finished" > "/dev/stderr"}
