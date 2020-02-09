#!/bin/bash

# Remember date
PROCESS_DATE=$(date +"%Y-%m-%d")

# Create new name
POST_NAME="$(openssl rand -hex 4)-commoncause"

# Save original name
ORIGINAL_FILE=$(basename $1)

# Change filetype if not already .jpg
ORIGINAL_EXT="${ORIGINAL_FILE##*.}"
ORIGINAL_NAME="${ORIGINAL_FILE%.*}"

if [ $ORIGINAL_EXT != ".jpg" ]
then
  magick convert $1 "$POST_NAME.jpg"
else
  cp $1 "$POST_NAME.jpg"
fi

# Resize to max pixels
magick convert "$POST_NAME.jpg" -resize 3000000@ "$POST_NAME.jpg"

# Remove Metadata
exiv2 rm "$POST_NAME.jpg"

# Archive original name and new name
echo "$PROCESS_DATE,$ORIGINAL_NAME.$ORIGINAL_EXT,$POST_NAME.jpg" >> cc_photo_archive.csv
