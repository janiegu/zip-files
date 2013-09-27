#!/bin/bash                                                                                                       

mkdir -p geojsonCounty topojsonCounty

for (( s=1; s <= 78; s++ ))
do
	i=$s
    if [ $i -lt 10 ]
        then
        i=$(echo "0"$i)
	fi
	curl -O $(echo "ftp://ftp2.census.gov/geo/tiger/TIGER2010/COUNTY/2010/tl_2010_"$i"_county10.zip")
	unzip $(echo "tl_2010_"$i"_county10.zip")
	ogr2ogr -f "GeoJSON" $(echo "geojsonCounty/"$i".json") $(echo "tl_2010_"$i"_county10.shp")
	topojson -p --out $(echo "topojsonCounty/"$i".json") $(echo "geojsonCounty/"$i".json")
	rm $(echo "tl_2010_"$i"_county10.dbf") $(echo "tl_2010_"$i"_county10.prj") $(echo "tl_2010_"$i"_county10.shp") $(echo "tl_2010_"$i"_county10.shp.xml") $(echo "tl_2010_"$i"_county10.shx") $(echo "tl_2010_"$i"_county10.zip")
done