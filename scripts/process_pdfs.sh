#!/bin/bash 
FILES=pdfs/*
HTML=$HOME/expt/html
echo "**************************************************"
echo "Target = $HTML"
echo "**************************************************"
for f in $FILES
do
	OUT_PATH="$HTML/$(basename $f .pdf)"
	echo $OUT_PATH
	pdftohtml -c  $f 
	mkdir "$OUT_PATH"
	mv pdfs/*.png $OUT_PATH
	mv pdfs/*.html $OUT_PATH
done

