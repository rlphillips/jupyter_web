#!/usr/bin/bash

#run nbconvert on a notebook, copy to the templates folter, create a new template and render.

#First argument: File name of the notebook to work on: e.g., if the notebook is analysis.ipynb, argument is analysis.

cd notebooks/
jupyter nbconvert --template basic $1.ipynb
cp $1.html ../templates/
cd ..

sed -r "s/FNAME/'$1.html'/g" ./templates/main.html > ./templates/main_$1.html

python render.py main_$1.html output_$1.html