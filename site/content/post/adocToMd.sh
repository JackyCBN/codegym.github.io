#!/bin/bash
FILE=$1
NAME=`echo "$FILE" | cut -d'.' -f1`

#asciidoctor -b docbook foo.adoc
echo '1. convert adoc to docbook:'$NAME".xml"
asciidoctor -b docbook $NAME".adoc"

#pandoc -f docbook -t gfm foo.xml -o foo.md
echo '2. convert docbook to markdown:'$NAME".md"
pandoc -f docbook -t gfm $NAME.xml -o $NAME.md

echo '3. rm:'$NAME".xml"
rm $NAME.xml