#!/usr/bin/bash

#run nbconvert on a notebook, copy to the templates folter, create a new template and render.

#First argument: File name of the notebook to work on: e.g., if the notebook is analysis.ipynb, argument is analysis.
#Second argument: Output directory.
#Third argument: title of the post
TITLE=$3
OUTPUT_DIR=$2
POST_DATE=`date +'%Y'-%m-%d`
cd notebooks/
echo "Converting"
jupyter nbconvert --to markdown  $1.ipynb

cd ..
echo "Appending to base post"
cp ./base_post.md  $OUTPUT_DIR/$POST_DATE-$1.md

echo "Copying images"
mkdir $OUTPUT_DIR/images/
cat ./notebooks/$1.md | tee -a $OUTPUT_DIR/$POST_DATE-$1.md
cp ./notebooks/$1_files/* $OUTPUT_DIR/images/
echo "Replacing $1"

sed -ri "s/__TITLE__/$TITLE/g" $OUTPUT_DIR/$POST_DATE-$1.md
sed -ri "s/__DATE__/$POST_DATE/g" $OUTPUT_DIR/$POST_DATE-$1.md
sed -ri "s/$1_files/\/assets\/images\//g" $OUTPUT_DIR/$POST_DATE-$1.md

#cd ..

#sed -r "s/FNAME/'$1.html'/g" ./templates/main.html > ./templates/main_$1.html

#python render.py main_$1.html output_$1.html
