#!/bin/bash                                                                                                       

mkdir -p geojson topojson

for (( s=1; s <= 78; s++ ))
do
	i=$s
    if [ $i -lt 10 ]
        then
        i=$(echo "0"$i)
	fi
	curl -O $(echo "ftp://ftp2.census.gov/geo/tiger/TIGER2010/ZCTA5/2010/tl_2010_"$i"_zcta510.zip")
	    unzip $(echo "tl_2010_"$i"_zcta510.zip")
	ogr2ogr -f "GeoJSON" $(echo "geojson/"$i".json") $(echo "tl_2010_"$i"_zcta510.shp")
	topojson -p --out $(echo "topojson/"$i".json") $(echo "geojson/"$i".json")
	rm $(echo "tl_2010_"$i"_zcta510.dbf") $(echo "tl_2010_"$i"_zcta510.prj") $(echo "tl_2010_"$i"_zcta510.shp") $(echo "tl_2010_"$i"_zcta510.shp.xml") $(echo "tl_2010_"$i"_zcta510.shx") $(echo "tl_2010_"$i"_zcta510.zip")
done
