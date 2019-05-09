
# gbifimagedata

An R package to get gbif image stats from the api in order to look for good datasets for machine learning. 


# Installation  

Need to install both of these R packages using devtools. 

```
install.packages("devtools")

devtools::install_github("jhnwllr/gbifapi") # depends on some functions here
devtools::install_github("jhnwllr/gbifimagedata")

install.packages("tidyverse") # will probably avoid some dependecy issues
```

# Usage 

The following should return a table of **frog image data stats**. 

## Simple example for testing 

Increase the `Step` and `maxPages` arguments in order to get more occurrences (more image data). Limited to 200,000 records. There is information on larger groups [here](https://jhnwllr.github.io/charts/percentCoverageTable). 

```
library(gbifimagedata)
library(dplyr)

getImageData(friendlyName="frogs",friendlyKey="952",Step=10,maxPages=2) %>% 
filter(taxonomicStatus == "ACCEPTED") %>% # get only ACCEPTED species
filter(rank == "SPECIES") %>% # only get for Rank SPECIES
addLicenseTranslation() %>%
summariseTable() %>%
filter(imageCount >= 1) %>% # only get species with more than n images
groupSummarise() %>%
filter(country == "world") %>% 
addPercentCoverage(globalOnly=TRUE) %>%
addWorldPercentage() %>% # adds through a different api
select(friendlyName,country,basisOfRecord,license,percentCoverage) %>%  
arrange(-percentCoverage,license)

```

This should return a table looking something like this... 

Since we only dowloaded 30 records, this table will be not very useful. 

**percentCoverage** = ( totalSpeciesWithImages / totalSpeciesInCountry ) * 100

**country** can be the world as it is below. 

```
 friendlyName country basisOfRecord    license                  percentCoverage
  <chr>        <chr>   <chr>            <chr>                              <dbl>
1 frogs        world   HUMAN_OBSERVATI~ only non-commercial use~           0.313
2 frogs        world   HUMAN_OBSERVATI~ total                              0.313

```

## Real example (Frogs)

Below I do a real analysis: 

This will take probably **5-10 minutes to download the data**. But you can save the data at each step just in case something goes wrong using `saveData`. 

```
library(gbifimagedata)
library(dplyr)

saveDir = "C:/Users/ftw712/Desktop/image data friendly taxa/data/frogs/"

getImageData(friendlyName="frogs",friendlyKey="952",Step=100,maxPages=2000) %>% 
saveData(saveDir,fileName="imageData.rda") %>% # save the data from the most expensive step
loadData(saveDir=saveDir,fileName="imageData.rda") %>% # load that data from disk
filter(taxonomicStatus == "ACCEPTED") %>% # get only ACCEPTED species
filter(rank == "SPECIES") %>% # only get for Rank SPECIES
addLicenseTranslation() %>%
summariseTable() %>%
filter(imageCount >= 1) %>% # only get species with more than n images
groupSummarise() %>%
filter(country == "world") %>% 
addPercentCoverage(globalOnly=TRUE) %>%
addWorldPercentage() %>% # adds through a different api
select(friendlyName,country,basisOfRecord,license,percentCoverage) %>%  
arrange(-percentCoverage,license)
```

Here I am skipping the expensive species counts for each country (in `addpercentCoverage` ) by using `globalOnly=TRUE`. 

This should produce a table looking close to this: 

```
  friendlyName country basisOfRecord     license                percentCoverage
   <chr>        <chr>   <chr>             <chr>                            <dbl>
 1 frogs        world   PRESERVED_SPECIM~ total                          23.4   
 2 frogs        world   HUMAN_OBSERVATION total                          18.6   
 3 frogs        world   HUMAN_OBSERVATION only non-commercial u~         17.6   
 4 frogs        world   PRESERVED_SPECIM~ commercial use allowed         13.4   
 5 frogs        world   PRESERVED_SPECIM~ only non-commercial u~         11.0   
 6 frogs        world   HUMAN_OBSERVATION commercial use allowed          6.18  
 7 frogs        world   UNKNOWN           only non-commercial u~          0.122 
 8 frogs        world   UNKNOWN           total                           0.122 
 9 frogs        world   FOSSIL_SPECIMEN   commercial use allowed          0.0136
10 frogs        world   FOSSIL_SPECIMEN   total                           0.0136

```

* 23% of frog species have 1 image or more (preserved specimen)
* 13% of frog species allow for commercial use (preserved specimen)

# TODO 

* make work for GENUS level or higher
* lists of taxonKeys. 
* make total group for basisOfRecord 

# Future Directions

*  Probably we need looking at the GENUS level would yield better coverage for all groups, might be more realistic. 
* Preserved specimen labels might be an issue

# Comments about GBIF images data
* There are 3x as many preserved specimen (10M) as human observation (30M) images. So we should expect any analysis to quite frequently only give us good coverage for preserved specimens. 


# top dataset possibilities

Any bird. 

1. swallowtail butterflies (9417)
2. bats (734)
3. Beech and Oak Tree Family (4689)
4. Ants (4342)

# Hummingbirds 

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=5289

```
  totalSpeciesWorld numWithImages basisOfRecord  license         percentCoverage
              <int>         <int> <chr>          <chr>                     <dbl>
1               574           306 HUMAN_OBSERVA~ total                     53.3 
2               574           294 HUMAN_OBSERVA~ only non-comme~           51.2 
3               574           243 PRESERVED_SPE~ total                     42.3 
4               574           227 PRESERVED_SPE~ commercial use~           39.5 
5               574           133 HUMAN_OBSERVA~ commercial use~           23.2 
6               574            30 PRESERVED_SPE~ only non-comme~            5.23
```

* %53 of hummingbirds have at least 1 image (human obs)
* 306 of 574 species
* %23 of hummingbirds species allow for commercial usage (human obs)


# Swallowtail butterflies 

https://www.gbif.org/occurrence/gallery?basis_of_record=PRESERVED_SPECIMEN&media_type=StillImage&taxon_key=9417

```
   friendlyName       country basisOfRecord   license            percentCoverage
   <chr>              <chr>   <chr>           <chr>                        <dbl>
 1 swallowtail butte~ world   PRESERVED_SPEC~ total                       62.7  
 2 swallowtail butte~ world   PRESERVED_SPEC~ commercial use al~          42.2  
 3 swallowtail butte~ world   HUMAN_OBSERVAT~ total                       38.2  
 4 swallowtail butte~ world   HUMAN_OBSERVAT~ only non-commerci~          36.8  
 5 swallowtail butte~ world   PRESERVED_SPEC~ only non-commerci~          26.8  
 6 swallowtail butte~ world   HUMAN_OBSERVAT~ commercial use al~          15.8  
 7 swallowtail butte~ world   UNKNOWN         total                        4.77 
 8 swallowtail butte~ world   UNKNOWN         only non-commerci~           3.58 
 9 swallowtail butte~ world   UNKNOWN         commercial use al~           1.64 
10 swallowtail butte~ world   FOSSIL_SPECIMEN commercial use al~           0.149
11 swallowtail butte~ world   FOSSIL_SPECIMEN total                        0.149
```

* 62% of swallowtail butterflies have 1 or more images (preserved specimen) 
* 421 species with images
* 42% with commerical use allowed (preserved specimen)
* A lot of museum drawers full of butterflies!

# Bats

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=734

```
   totalSpeciesWorld numWithImages basisOfRecord  license        percentCoverage
               <int>         <int> <chr>          <chr>                    <dbl>
 1              1592           514 PRESERVED_SPE~ total                   32.3  
 2              1592           470 HUMAN_OBSERVA~ total                   29.5  
 3              1592           449 HUMAN_OBSERVA~ only non-comm~          28.2  
 4              1592           316 PRESERVED_SPE~ commercial us~          19.8  
 5              1592           105 PRESERVED_SPE~ only non-comm~           6.60 
 6              1592           100 HUMAN_OBSERVA~ commercial us~           6.28 
 7              1592             2 FOSSIL_SPECIM~ commercial us~           0.126
 8              1592             2 UNKNOWN        only non-comm~           0.126
 9              1592             2 FOSSIL_SPECIM~ total                    0.126
10              1592             2 UNKNOWN        total                    0.126
```
 
* 32% with images (preserved specimen)
* 514 of 1592 (preserved specimen)
* 19% commercial use allowed (preserved specimen)
* 28% with images (human observation)

# Ants  

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=4342


```
   totalSpeciesWorld numWithImages basisOfRecord  license        percentCoverage
               <int>         <int> <chr>          <chr>                    <dbl>
 1             13504          8290 PRESERVED_SPE~ total                   61.4  
 2             13504          8270 PRESERVED_SPE~ only non-comm~          61.2  
 3             13504           675 HUMAN_OBSERVA~ total                    5.00 
 4             13504           626 HUMAN_OBSERVA~ only non-comm~           4.64 
 5             13504           235 HUMAN_OBSERVA~ commercial us~           1.74 
 6             13504           152 PRESERVED_SPE~ commercial us~           1.13 
 7             13504           152 UNKNOWN        total                    1.13 
 8             13504           136 UNKNOWN        only non-comm~           1.01 
 9             13504            66 FOSSIL_SPECIM~ total                    0.489
10             13504            55 FOSSIL_SPECIM~ only non-comm~           0.407
11             13504            31 FOSSIL_SPECIM~ commercial us~           0.230
12             13504            19 UNKNOWN        commercial us~           0.141
```

* 64% of ants have 1 or more images (preserved specimen)
* 8290 of 13504 species
* well above average for insects which is 50% 
* Only 1% of ants species allow for commercial use (preserved specimen)

# Beech and Oak Tree Family 

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=4689

```
   totalSpeciesWorld numWithImages basisOfRecord  license        percentCoverage
               <int>         <int> <chr>          <chr>                    <dbl>
 1              1478           931 PRESERVED_SPE~ total                   63.0  
 2              1478           787 PRESERVED_SPE~ commercial us~          53.2  
 3              1478           404 PRESERVED_SPE~ only non-comm~          27.3  
 4              1478           244 HUMAN_OBSERVA~ total                   16.5  
 5              1478           240 HUMAN_OBSERVA~ only non-comm~          16.2  
 6              1478           105 HUMAN_OBSERVA~ commercial us~           7.10 
 7              1478            32 FOSSIL_SPECIM~ total                    2.17 
 8              1478            30 FOSSIL_SPECIM~ commercial us~           2.03 
 9              1478            11 LIVING_SPECIM~ only non-comm~           0.744
10              1478            11 LIVING_SPECIM~ total                    0.744
11              1478             2 OBSERVATION    only non-comm~           0.135
12              1478             2 OBSERVATION    total                    0.135

```

* 63% with images (preserved specimen)
* 53% with commercial use allowed (preserved specimen)
* 931 of 1478 species 

# dragonfly family libellulidae

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=5936


```
   totalSpeciesWorld numWithImages basisOfRecord  license        percentCoverage
               <int>         <int> <chr>          <chr>                    <dbl>
 1              1106           442 HUMAN_OBSERVA~ total                  40.0   
 2              1106           426 HUMAN_OBSERVA~ only non-comm~         38.5   
 3              1106           281 PRESERVED_SPE~ total                  25.4   
 4              1106           241 HUMAN_OBSERVA~ commercial us~         21.8   
 5              1106            92 PRESERVED_SPE~ commercial us~          8.32  
 6              1106            21 PRESERVED_SPE~ only non-comm~          1.90  
 7              1106             9 FOSSIL_SPECIM~ total                   0.814 
 8              1106             8 FOSSIL_SPECIM~ commercial us~          0.723 
 9              1106             1 FOSSIL_SPECIM~ only non-comm~          0.0904
10              1106             1 UNKNOWN        only non-comm~          0.0904
11              1106             1 UNKNOWN        total                   0.0904
```

* 40% with images(human obs)
* 21% commericial use 
* 442 of 1106 species

# Spiders

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=1496

```
   totalSpeciesWorld numWithImages basisOfRecord  license        percentCoverage
               <int>         <int> <chr>          <chr>                    <dbl>
 1             49560          2508 HUMAN_OBSERVA~ total                   5.06  
 2             49560          2113 HUMAN_OBSERVA~ only non-comm~          4.26  
 3             49560           981 PRESERVED_SPE~ total                   1.98  
 4             49560           921 PRESERVED_SPE~ only non-comm~          1.86  
 5             49560           818 HUMAN_OBSERVA~ commercial us~          1.65  
 6             49560           603 UNKNOWN        total                   1.22  
 7             49560           598 UNKNOWN        only non-comm~          1.21  
 8             49560            57 UNKNOWN        commercial us~          0.115 
 9             49560            47 FOSSIL_SPECIM~ total                   0.0948
10             49560            36 FOSSIL_SPECIM~ commercial us~          0.0726
11             49560            12 MATERIAL_SAMP~ only non-comm~          0.0242
12             49560            12 MATERIAL_SAMP~ total                   0.0242
13             49560            11 FOSSIL_SPECIM~ only non-comm~          0.0222
14             49560            10 PRESERVED_SPE~ commercial us~          0.0202
```

* Only 5% of spiders have 1 or more images 
* 2508 of 49560 species with images 
* Although percentage is low, almost all are human observation. 

# orb-weaving spiders

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=7359

```
  totalSpeciesWorld numWithImages basisOfRecord  license         percentCoverage
              <int>         <int> <chr>          <chr>                     <dbl>
1              3208           409 HUMAN_OBSERVA~ total                   12.7   
2              3208           392 HUMAN_OBSERVA~ only non-comme~         12.2   
3              3208           158 HUMAN_OBSERVA~ commercial use~          4.93  
4              3208            11 PRESERVED_SPE~ total                    0.343 
5              3208            10 PRESERVED_SPE~ only non-comme~          0.312 
6              3208             3 UNKNOWN        only non-comme~          0.0935
7              3208             3 UNKNOWN        total                    0.0935

```

* 12% with images (human observation)
* 409 of 3208 species 
* Only 4% allow for commercial use (human observation)


# Scorpions 

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=872

```   
   totalSpeciesWorld numWithImages basisOfRecord  license        percentCoverage
               <int>         <int> <chr>          <chr>                    <dbl>
 1              2502           307 HUMAN_OBSERVA~ total                   12.3  
 2              2502           294 HUMAN_OBSERVA~ only non-comm~          11.8  
 3              2502           159 PRESERVED_SPE~ total                    6.35 
 4              2502            56 HUMAN_OBSERVA~ commercial us~           2.24 
 5              2502            35 PRESERVED_SPE~ only non-comm~           1.40 
 6              2502             8 FOSSIL_SPECIM~ commercial us~           0.320
 7              2502             8 FOSSIL_SPECIM~ total                    0.320
 8              2502             6 PRESERVED_SPE~ commercial us~           0.240
 9              2502             6 UNKNOWN        only non-comm~           0.240
10              2502             6 UNKNOWN        total                    0.240
```

* 12% with images (human obs)
* 294 of 2502 species
* 2% commercial use allowed (human obs)



# Primates 

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=798

```
  totalSpeciesWorld numWithImages basisOfRecord  license         percentCoverage
              <int>         <int> <chr>          <chr>                     <dbl>
1              1192           269 HUMAN_OBSERVA~ total                     22.6 
2              1192           260 HUMAN_OBSERVA~ only non-comme~           21.8 
3              1192           111 PRESERVED_SPE~ total                      9.31
4              1192           101 HUMAN_OBSERVA~ commercial use~            8.47
5              1192            78 PRESERVED_SPE~ commercial use~            6.54
6              1192            50 FOSSIL_SPECIM~ commercial use~            4.19
7              1192            50 FOSSIL_SPECIM~ total                      4.19
8              1192            47 PRESERVED_SPE~ only non-comme~            3.94

```

* Only 22.6% with images (human observation)
* 8% allowing commercial use
* 269 of 1192 with images

# Rodents

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=1459

```
totalSpeciesWorld numWithImages basisOfRecord  license         percentCoverage
              <int>         <int> <chr>          <chr>                     <dbl>
1              4909           516 HUMAN_OBSERVA~ total                   10.5   
2              4909           489 HUMAN_OBSERVA~ only non-comme~          9.96  
3              4909           477 PRESERVED_SPE~ total                    9.72  
4              4909           379 PRESERVED_SPE~ commercial use~          7.72  
5              4909           181 HUMAN_OBSERVA~ commercial use~          3.69  
6              4909           154 PRESERVED_SPE~ only non-comme~          3.14  
7              4909            62 FOSSIL_SPECIM~ total                    1.26  
8              4909            61 FOSSIL_SPECIM~ commercial use~          1.24  
9              4909             2 FOSSIL_SPECIM~ only non-comme~          0.0407
```

* 10.5% with images (human observation)
* 516 species with images out of 4909 accepted species
* 7% allow for commercial use

# Dragonflies 

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=789

```
  totalSpeciesWorld numWithImages basisOfRecord  license         percentCoverage
              <int>         <int> <chr>          <chr>                     <dbl>
1              7040          1450 HUMAN_OBSERVA~ total                   20.6   
2              7040          1369 HUMAN_OBSERVA~ only non-comme~         19.4   
3              7040           701 HUMAN_OBSERVA~ commercial use~          9.96  
4              7040           428 PRESERVED_SPE~ total                    6.08  
5              7040            49 PRESERVED_SPE~ only non-comme~          0.696 
6              7040             4 PRESERVED_SPE~ commercial use~          0.0568
```

* 20% of dragonflies have images (human observation)
* 10% commercial use allowed (human observation)
* 1450 of 7040 species

Numbers might be slightly better since dragonflies have 227 427 occurrences with images


# Venomous snake family Elapidae

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=9455

```
1               398           173 HUMAN_OBSERVA~ total                     43.5 
2               398           161 HUMAN_OBSERVA~ only non-comme~           40.5 
3               398           146 PRESERVED_SPE~ total                     36.7 
4               398           120 PRESERVED_SPE~ commercial use~           30.2 
5               398            64 HUMAN_OBSERVA~ commercial use~           16.1 
6               398            21 PRESERVED_SPE~ only non-comme~           5.28
```

* 43% with images (human observation)
* 16% commercial use (human observation)
* 40% only-non commercial use allowed
* 173 of 398 species with images


# Cactus

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=2519

```
totalSpeciesWorld numWithImages basisOfRecord  license        percentCoverage
1              1816          1063 PRESERVED_SPE~ total                    58.5  
2              1816           776 PRESERVED_SPE~ commercial use~          42.7  
3              1816           658 HUMAN_OBSERVA~ total                    36.2  
4              1816           649 HUMAN_OBSERVA~ only non-comme~          35.7  
5              1816           469 PRESERVED_SPE~ only non-comme~          25.8  
6              1816           211 HUMAN_OBSERVA~ commercial use~          11.6  
7              1816             9 LIVING_SPECIM~ only non-comme~           0.496
8              1816             9 LIVING_SPECIM~ total                     0.496
```

* 58.5% with images (preserved specimen)
* 36% commercial use allowed (human observation)
* 1063 of 1816 with images 



# Lichens

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=1048

```
  totalSpeciesWorld numWithImages basisOfRecord  license         percentCoverage
              <int>         <int> <chr>          <chr>                     <dbl>
1              7478          2477 PRESERVED_SPE~ total                   33.1   
2              7478          1925 PRESERVED_SPE~ only non-comme~         25.7   
3              7478           801 PRESERVED_SPE~ commercial use~         10.7   
4              7478           732 HUMAN_OBSERVA~ total                    9.79  
5              7478           624 HUMAN_OBSERVA~ only non-comme~          8.34  
6              7478           323 HUMAN_OBSERVA~ commercial use~          4.32  
7              7478             1 UNKNOWN        only non-comme~          0.0134
8              7478             1 UNKNOWN        total                    0.0134

```

* 33% with images (preserved specimen)
* 2477 of 7478 species (preserved specimen)
* 10% commercial use allowed (preserved specimen)
* 10% with images (human obs)


# Great apes

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=5483

```
  totalSpeciesWorld numWithImages basisOfRecord  license         percentCoverage
              <int>         <int> <chr>          <chr>                     <dbl>
1                81             7 PRESERVED_SPE~ total                      8.64
2                81             5 PRESERVED_SPE~ commercial use~            6.17
3                81             5 HUMAN_OBSERVA~ total                      6.17
4                81             3 HUMAN_OBSERVA~ commercial use~            3.70
5                81             3 HUMAN_OBSERVA~ only non-comme~            3.70
6                81             3 PRESERVED_SPE~ only non-comme~            3.70
```

* Probably we have better coverage for this group than what is in the table since most of the family Hominidae is extinct. 





# Rabbits

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=785

```
  totalSpeciesWorld numWithImages basisOfRecord  license         percentCoverage
              <int>         <int> <chr>          <chr>                     <dbl>
1               318            61 HUMAN_OBSERVA~ total                     19.2 
2               318            58 HUMAN_OBSERVA~ only non-comme~           18.2 
3               318            26 HUMAN_OBSERVA~ commercial use~            8.18
4               318            23 PRESERVED_SPE~ total                      7.23
5               318            18 PRESERVED_SPE~ commercial use~            5.66
6               318             9 FOSSIL_SPECIM~ commercial use~            2.83
7               318             9 PRESERVED_SPE~ only non-comme~            2.83
8               318             9 FOSSIL_SPECIM~ total                      2.83
```
* 20% with images (human obs)
* 61 of 318 (human obs)
* 8% commercial use allowed (human obs)

# Ladybugs/Ladybirds

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=7782

```
   totalSpeciesWorld numWithImages basisOfRecord  license        percentCoverage
               <int>         <int> <chr>          <chr>                    <dbl>
 1              2059           228 HUMAN_OBSERVA~ total                   11.1  
 2              2059           214 HUMAN_OBSERVA~ only non-comm~          10.4  
 3              2059           175 PRESERVED_SPE~ total                    8.50 
 4              2059           107 PRESERVED_SPE~ only non-comm~           5.20 
 5              2059           104 HUMAN_OBSERVA~ commercial us~           5.05 
 6              2059            76 PRESERVED_SPE~ commercial us~           3.69 
 7              2059            58 UNKNOWN        only non-comm~           2.82 
 8              2059            58 UNKNOWN        total                    2.82 
 9              2059            11 FOSSIL_SPECIM~ total                    0.534
10              2059             8 FOSSIL_SPECIM~ only non-comm~           0.389
11              2059             3 FOSSIL_SPECIM~ commercial us~           0.146
```

* 11% with images (human observation)
* 228 of 2059 (human observation)
* 5% commercial use allowed (human observation)

# Land snails

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=6540

```
  totalSpeciesWorld numWithImages basisOfRecord  license         percentCoverage
              <int>         <int> <chr>          <chr>                     <dbl>
1              1723           530 PRESERVED_SPE~ total                    30.8  
2              1723           464 PRESERVED_SPE~ commercial use~          26.9  
3              1723            32 FOSSIL_SPECIM~ total                     1.86 
4              1723            31 FOSSIL_SPECIM~ commercial use~           1.80 
5              1723            24 HUMAN_OBSERVA~ only non-comme~           1.39 
6              1723            24 HUMAN_OBSERVA~ total                     1.39 
7              1723            11 HUMAN_OBSERVA~ commercial use~           0.638
8              1723            10 PRESERVED_SPE~ only non-comme~           0.580
```

* 30% with images (preserved specimen)
* 530 of 1723 species (preserved specimen)
* 26% commercial use allowed (preserved specimen)
* Might be a lot of specimen labels

https://www.gbif.org/occurrence/gallery?basis_of_record=PRESERVED_SPECIMEN&media_type=StillImage&taxon_key=6540

# Bivalves

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=137

```
   totalSpeciesWorld numWithImages basisOfRecord  license        percentCoverage
               <int>         <int> <chr>          <chr>                    <dbl>
 1             26436          2431 FOSSIL_SPECIM~ total                   9.20  
 2             26436          2382 PRESERVED_SPE~ total                   9.01  
 3             26436          1516 PRESERVED_SPE~ commercial us~          5.73  
 4             26436          1203 FOSSIL_SPECIM~ commercial us~          4.55  
 5             26436           878 HUMAN_OBSERVA~ total                   3.32  
 6             26436           810 HUMAN_OBSERVA~ only non-comm~          3.06  
 7             26436           289 HUMAN_OBSERVA~ commercial us~          1.09  
 8             26436           107 PRESERVED_SPE~ only non-comm~          0.405 
 9             26436             7 UNKNOWN        only non-comm~          0.0265
10             26436             7 UNKNOWN        total                   0.0265
11             26436             4 FOSSIL_SPECIM~ only non-comm~          0.0151
```
* 10% with images (fossil)
* 10% with images (preserved specimen)
* 2382 of 26436 species
* 5% commercial use allowed (preserved specimens)
* Huge amount of species also with fossils, so situation might be better than table implies. Probably would be a hard dataset to use. 


# Feather mosses

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=617

```
  totalSpeciesWorld numWithImages basisOfRecord  license         percentCoverage
              <int>         <int> <chr>          <chr>                     <dbl>
1              7012          3365 PRESERVED_SPE~ total                    48.0  
2              7012          2953 PRESERVED_SPE~ commercial use~          42.1  
3              7012           759 PRESERVED_SPE~ only non-comme~          10.8  
4              7012           202 HUMAN_OBSERVA~ total                     2.88 
5              7012           137 HUMAN_OBSERVA~ only non-comme~           1.95 
6              7012            47 HUMAN_OBSERVA~ commercial use~           0.670
```

* 48% with images (preserved specimen)
* 3365 of 7012 species (preserved specimen)
* 42% commercial use allowed (preserved specimen)
* Might be a good dataset. A lot of preserved specimens. 


# Sharks 

https://www.gbif.org/occurrence/gallery?media_type=StillImage&taxon_key=121

```
   totalSpeciesWorld numWithImages basisOfRecord  license        percentCoverage
               <int>         <int> <chr>          <chr>                    <dbl>
 1              1971           538 PRESERVED_SPE~ total                   27.3  
 2              1971           449 PRESERVED_SPE~ commercial us~          22.8  
 3              1971           347 HUMAN_OBSERVA~ total                   17.6  
 4              1971           298 HUMAN_OBSERVA~ only non-comm~          15.1  
 5              1971           157 HUMAN_OBSERVA~ commercial us~           7.97 
 6              1971           155 PRESERVED_SPE~ only non-comm~           7.86 
 7              1971            43 FOSSIL_SPECIM~ total                    2.18 
 8              1971            29 FOSSIL_SPECIM~ commercial us~           1.47 
 9              1971             9 FOSSIL_SPECIM~ only non-comm~           0.457
10              1971             7 UNKNOWN        total                    0.355
11              1971             4 UNKNOWN        commercial us~           0.203
12              1971             3 UNKNOWN        only non-comm~           0.152
```

* 27% with images (preserved specimen)
* 538 of 1971 species
* 22% allowing for commercial use
 


  

