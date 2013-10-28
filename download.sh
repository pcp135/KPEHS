#!/bin/bash

wget -x -nd --load-cookies cookies.txt http://www.kaggle.com/c/expedia-personalized-sort/download/data.zip
unzip data.zip
rm data.zip