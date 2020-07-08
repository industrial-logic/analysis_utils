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
    lineNumber=$4
	gsub(/\\/, "/", file)
	sub(currentDir,"",file)
	gsub(/C:./,"",file)
	gsub(/^\//,"",file)
	printf "%5d, %5d, %4d, (%s:%d)\n", currentId, currentLines, currentTokens, file, lineNumber
	next; 
}

{ next; }
