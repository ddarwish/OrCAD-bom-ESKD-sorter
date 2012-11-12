#!/usr/bin/awk -f

BEGIN {
    FS = "\t"
    RS = "\n"
    skip = 1
}

/^[ \r\t]*$/ { next }

/_____/ {
    skip = 0
    next
}

{
    if (skip)
	next
    split($1, parts, ",")
    for (p in parts) {
	n = match(parts[p], "[0-9]+")
	c = substr(parts[p], 1, n-1)
	if (c == "") {
	    print "Empty component name at line " FNR "! Aborting"
	    exit
	}
	i = substr(parts[p], n)
	if (c in comp_types) {
	    #print "an comp " c " " comp_types[c] " " i
	    comp_types[c]++
	} else
	    comp_types[c] = 1
	components[c , i , "komp_name"] = $3
	components[c , i , "part_number"] = $7
	components[c , i , "value"] = $5
    }
}

END {
    n = 1
    compqnt = 0
    for (c in comp_types) {
	#print "heyho " c
	q = 0
	for (i=1; q<comp_types[c]; i++) {
	    #print "comp_types" i " " comp_types[c]
	    if ( (c, i, "komp_name") in components ) {
	    	#print "komp_name " c i
		knc = components[c , i , "komp_name"]
		pnc = components[c , i , "part_number"]
		valuec = components[c , i , "value"]
		if (kn == knc && pn == pnc && value == valuec) {
		    compref = compref "," c i
		    compqnt++
		} else {
		    if (compqnt != 0) {
			print n "\t" compref "\t" kn "\t" pn "\t" value "\t" compqnt
			n++
		    }
		    compref = c i
		    kn = knc
		    pn = pnc
		    value = valuec
		    compqnt = 1
		}
		q++
	    }
	}
    }
    print n "\t" compref "\t" kn "\t" pn "\t" value "\t" compqnt
}
