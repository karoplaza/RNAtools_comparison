BEGIN { 
    FS = OFS = ","
}


NR == FNR {
   mapping[$1] = $2
   next
}

{
    for (i =1; i<= NF; i++) {
       if (i == 1 || i == 4) {
           if ($i in mapping) {
              $i = mapping[$i]
           }
        }
    }
    print
}

