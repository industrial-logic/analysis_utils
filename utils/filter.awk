#!/usr/bin/awk -f


BEGIN { 
    FS = ","

    if(minimumTokens == "")
        minimumTokens = 20
}

/.*/ { 
    if($5 > minimumTokens) 
        print $0
}
