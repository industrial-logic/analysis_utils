#!/usr/bin/awk -f

function recordDuplicatedLines() {
   delete biggestDupLines
   currentIndex = 0
   for (line in currentDupLines) {
       biggestDupLines[currentIndex++] = currentDupLines[line]
   }
}

BEGIN { 
    biggestSize = -1
    biggestId = 0
    lastId = 0
    currentCount = 0
    currentLines = 0
}

{ 
    currentId = $1
	currentLines = $2 

    if(currentId != lastId) {
        size = currentCount * currentLines
        if(size > biggestSize) {
           biggestSize = size
           biggestId = lastId

           recordDuplicatedLines()
        }
        delete currentDupLines
        currentDupLines[0] = $0
        currentCount = 1
        lastId = currentId
    } else {
        currentDupLines[currentCount++] = $0
    }
    next
}

END { 
	printf "Id: %d, Total Size: %d\n", biggestId, biggestSize
    lines = allLines[biggestId]
    for (line in biggestDupLines) print biggestDupLines[line]
}
