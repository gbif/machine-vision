#!/bin/zsh -e
#
# Add images to a GBIF DWCA download.
#
# Argument: the download key, such as 0025086-181108115102211
#
# Issues: Some "images" are actually audio, video or other formats, or the URL fails.
#           This should be handled properly with improvements to our ingestion/interpretation processes.
#           (In other words, by making it possible to omit bad "images" from the download.)
#

key=$1

dir=dl.$key.$RANDOM
mkdir $dir
cd $dir

mkdir -p images

echo "Retrieving download $key"
curl -fO http://api.gbif.org/v1/occurrence/download/request/$key.zip

echo "Uncompressing download"
unzip $key.zip

echo "gbifid	url	image_name	thumb_url" > image-names

wc -l multimedia.txt

tail -n +2 multimedia.txt | cut -d$'\t' -f 1,4 | while IFS=$'\t' read id url; do
  number=$RANDOM
  name=images/${id}_$number.jpg
  if [[ ( $url == "http"* ) && ( $url != *".cr2" ) && ( $url != *".mp4" ) && ( $url != *".mov" ) && ( $url != *".mp3" ) ]]; then
	  echo "Image $id; retrieving $url resized to 320×320."
	  curl -Ss --fail -o       $name --max-time 60 'http://api.gbif.org/v1/image/unsafe/fit-in/320x320/filters:format(jpg)/'$url || touch       "$name.problem"
	  if [[ -e "$name.problem" ]]; then
		  echo "$id	$url		" >> image-names
	  else
		  thumb_url=$(python ../imageurl 'fit-in/64x64/filters:format(jpg)' $url)
		  echo "$id	$url	$name	$thumb_url" >> image-names
	  fi
  else
	  echo "Image $id; skipping $url"
	  echo "$id	$url		" >> image-names
  fi
done | nl

mv multimedia.txt multimedia-original.txt

echo "gbifID	type	format	identifier	furtherInformationURL	title	description	CreateDate	creator	contributor	providerLiteral	audience	source	rights	Owner	Image	ThumbnailURL" > multimedia.txt

# Append columns to original file, then strip out rows without an image
paste multimedia-original.txt <(cut -d$'\t' -f 3,4 image-names) | tail -n +2 | grep -v $'\t\t$' >> multimedia.txt

if [[ -n "images/*.problem(N)" ]]; then
	echo "Problems retrieving these images:"
	ls images/*.problem
	mkdir images-problem
	mv images/*.problem images-problem
fi

mv meta.xml meta-original.xml

cp ../replacement-meta.xml meta.xml

[[ -e ../$key-images.zip ]] && rm ../$key-images.zip
zip -r ../$key-images.zip meta.xml metadata.xml citations.txt multimedia.txt occurrence.txt rights.txt verbatim.txt dataset images
