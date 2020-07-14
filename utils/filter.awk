#!/usr/bin/awk -f


BEGIN { 
    FS = ","

    if(minimumTokens == "")
        minimumTokens = 20
}

/.*/ { 
    if($3 > minimumTokens) 
        print $0
}
