## GBIF Multimedia
Preliminary numbers for images available through GBIF.


#### Summary

```
FROM prod_f.occurrence_multimedia 
SELECT count(*) AS numImages
WHERE type='StillImage'
=> 37,574,028

FROM prod_f.occurrence_multimedia 
SELECT count(DISTINCT gbifid) AS numRecords
WHERE type='StillImage'
=> 30,113,920
```

10 million more URLs to be analysed.

```
FROM 
  prod_f.occurrence_multimedia m
  JOIN prod_f.occurrence_hdfs o ON m.gbifid = o.gbifid
SELECT o.kingdom, count(DISTINCT o.gbifid) AS occurrenceCount
WHERE m.type='StillImage'
GROUP BY o.kingdom

1	NULL	1923249
2	Protozoa	14766
3	incertae sedis	8904
4	Animalia	8848714
5	Bacteria	47174
6	Plantae	18176909
7	Chromista	144453
8	Viruses	20
9	Archaea	5
10	Fungi	940763
```

```
FROM 
  prod_f.occurrence_multimedia m
  JOIN prod_f.occurrence_hdfs o ON m.gbifid = o.gbifid
SELECT o.kingdom, count(distinct o.speciesKey) as speciesCount
WHERE m.type='StillImage' 
GROUP BY o.kingdom

1	NULL	0
2	Protozoa	762
3	Viruses	0
4	Animalia	301911
5	Fungi	49201
6	Chromista	10977
7	Plantae	356184
8	incertae sedis	429
9	Archaea	2
10	Bacteria	1912
```

Species with 20 images
```
SELECT kingdom, count(distinct specieskey) as speciesCount
FROM 
  (
    SELECT o.kingdom, o.specieskey, count(*) as images 
    FROM 
      prod_f.occurrence_multimedia m
        JOIN prod_f.occurrence_hdfs o ON m.gbifid = o.gbifid
    WHERE m.type='StillImage'     
    GROUP BY o.kingdom, o.specieskey    
  )
WHERE images>=20
GROUP BY o.kingdom

1	NULL	0
2	Protozoa	149
3	Viruses	0
4	Animalia	48813
5	Fungi	8179
6	Chromista	866
7	Plantae	106577
8	incertae sedis	15
9	Bacteria	117
```

Species with 10 images
```
SELECT kingdom, count(distinct specieskey) as speciesCount
FROM 
  (
    SELECT o.kingdom, o.specieskey, count(*) as images 
    FROM 
      prod_f.occurrence_multimedia m
        JOIN prod_f.occurrence_hdfs o ON m.gbifid = o.gbifid
    WHERE m.type='StillImage'     
    GROUP BY o.kingdom, o.specieskey    
  )
WHERE images>=10
GROUP BY o.kingdom

NULL	0
2	Protozoa	243
3	Viruses	0
4	Animalia	88725
5	Fungi	13343
6	Chromista	1594
7	Plantae	155436
8	incertae sedis	33
9	Bacteria	189
```


#### Licenses

```
FROM prod_f.occurrence_multimedia 
SELECT license, count(*) AS numRecords
WHERE type='StillImage'
GROUP BY license
ORDER BY numRecords DESC
LIMIT 20
```

With some manual adjustments:

| License | Count |
|---------|------:|
|   CC-BY | 15,894 k |
| CC-BY-NC| 9,168 k  |
|  -      | 7,185 k  |
| CC-BY-NC-SA| 2,041 k  |
| CC0 | 914 k  |
| CC-BY-SA| 862 k  |
| CC-BY-NC-ND | 590 k  |
| Reserved | 464 k  |


TODO:
Using the licensed ok stuff
- counts by specimen vs other
- counts by non-specimen and birds, insects etc
- number of species with >20 images
- geographic area breakdowns (country)


#### Data volume

9,522,031 records in Thumbor cache totalling 19.2TB.
Averages 2MB per image

