#!/bin/bash                                                                                                       

mkdir -p geojson topojson

for (( i=1; i <= 78; i++ ))
do
    if [ $i -lt 10 ]
        then
	curl -O $(echo "ftp://ftp2.census.gov/geo/tiger/TIGER2010/ZCTA5/2010/tl_2010_0"$i"_zcta510.zip")
        unzip $(echo "tl_2010_0"$i"_zcta510.zip")
	ogr2ogr -f "GeoJSON" $(echo "geojson/0"$i".json") $(echo "tl_2010_0"$i"_zcta510.shp")
	topojson -p --id-property ZCTA5CE10 --out $(echo "topojson/0"$i".json") $(echo "geojson/0"$i".json")
    else
	curl -O $(echo "ftp://ftp2.census.gov/geo/tiger/TIGER2010/ZCTA5/2010/tl_2010_"$i"_zcta510.zip")
        unzip $(echo "tl_2010_"$i"_zcta510.zip")
	ogr2ogr -f "GeoJSON" $(echo "geojson/"$i".json") $(echo "tl_2010_"$i"_zcta510.shp")
	topojson -p --id-property ZCTA5CE10 --out $(echo "topojson/"$i".json") $(echo "geojson/"$i".json")
        fi
done
