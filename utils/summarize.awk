#!/usr/bin/awk -f

BEGIN { 
	currentDir=ENVIRON["PWD"]
	sub(/^\/[a-z]/,"",currentDir)
	gsub(/\//,"\\/",currentDir)
    nextId = 1
}

/Found a/ { 
	currentLines = $3 
	currentTokens =$5
    currentId = nextId++
	gsub(/^./,"",currentTokens); 
}

/Starting at/ { 
	file=$6
	gsub(/\\/, "/", file)
	sub(currentDir,"",file)
	gsub(/C:./,"",file)
	gsub(/^\//,"",file)
	print currentId "," file "," $4 "," currentLines "," currentTokens " (" file ":" $4 ")"
	next; 
}

{ next; }
