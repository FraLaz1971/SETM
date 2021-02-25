#!/usr/bin/awk -f
BEGIN 	{nh = 1}
/^#.*/	{print "skipping comment" > "/dev/stderr" } 
!/#/ 	{for (a=1; a<=NF;a++) h[a, nh] = $(a); nh+=1}
END 	{
  j = 1
  for(k=1; k<=NF; k++) {
    for (j=1; j<nh; j++) printf("%d ", h[k, j])
    printf("\n")
  }
  print "read " NR " records; processed " nh-1 " histos" >"/dev/stderr"
}