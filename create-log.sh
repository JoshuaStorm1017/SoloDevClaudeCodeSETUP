#!/bin/bash

# Create a new progress/debug log entry

# Ensure _logs directory exists
mkdir -p _logs

# Get the next number
if [ -z "$(ls -A _logs)" ]; then
    NEXT_NUM="001"
else
    LAST_NUM=$(ls _logs | sed 's/_.*//' | sort -n | tail -1)
    NEXT_NUM=$(printf "%03d" $((10#$LAST_NUM + 1)))
fi

# Get type and title
echo "Type: (f)eature or (d)ebug?"
read -r TYPE_CHOICE

if [ "$TYPE_CHOICE" = "d" ]; then
    TYPE="debug"
    WHAT_WORD="Fixed"
else
    TYPE="feature"
    WHAT_WORD="Built"
fi

echo "Title (e.g., 'add user auth' or 'fix memory leak'):"
read -r TITLE

# Create filename
FILENAME="${NEXT_NUM}_${TITLE// /_}.md"
DATE=$(date +%Y-%m-%d)

# Create the file
cat > "_logs/$FILENAME" << EOF
# $NEXT_NUM - $TITLE
Date: $DATE
Type: $TYPE

## What I $WHAT_WORD
- 

## Key ${TYPE^} Details
- 

## Code Locations
- 

## Testing
\`\`\`bash
# How to verify this works
\`\`\`

## Notes
- 

---
*Created by $USER*
EOF

echo "Created: _logs/$FILENAME"
echo "Opening in editor..."
${EDITOR:-nano} "_logs/$FILENAME"