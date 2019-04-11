

def pysparkDfToCSV(outputFile, collectedDf): # for use with small data.frames 
	import csv	
	with open(outputFile, 'wb') as f:  # Just use 'w' mode in 3.x
		w = csv.DictWriter(f, collectedDf[0].asDict().keys())
		w.writeheader()
		for row in collectedDf:
			dict = row.asDict()
			w = csv.DictWriter(f, dict.keys())
			try: 
				# dict = {str(k).encode('utf-8').decode('ascii', 'ignore'): str(v).encode('utf-8').decode('ascii', 'ignore') for k, v in dict.items()}
				w.writerow(dict)
			except:
				pass
	# f = open(outputFile,"r") # open a connection to read results 
	# print(f.read())


from pyspark.sql.functions import col,desc 

# get image data for datasets
df_mult = spark.sql("select gbifid, type, license from uat.occurrence_multimedia").filter("type = 'StillImage'")
df_occ = spark.sql("select gbifid, familykey, specieskey, basisofrecord, countrycode from uat.occurrence_hdfs")

D = df_mult.join(df_occ, df_mult.gbifid == df_occ.gbifid, 'outer')
D = D.filter(col("type").isNotNull())
D = D.filter("familykey = 4342") # get just ant data 
D = D.groupBy("specieskey","countrycode","basisofrecord")
D = D.count()


# D = D.filter("countrycode = 'US'")
# D = D.filter("basisofrecord = 'HUMAN_OBSERVATION'")
# D = D.filter("count > 10")



# D.count()

# D = D.filter(col("type").isNotNull())

# 774
# D = D.orderBy(desc("count"))

# 9498

# D = D.filter("count > 1")

# pysparkDfToCSV("imageDataTaxonKeyBasisOfRecordCountryCodeLicense.csv",D.collect())



# spark.catalog.clearCache()
# 1507807

# sqlContext.sql("show tables from snapshot").show()




	
# D.filter("type = 'StillImage'").groupBy("license","type").count().orderBy(desc("count")).show()
# df = spark.sql("select * from snapshot.raw_" + snapshot)
# 33M
# df_image = D.filter("type = 'StillImage'")
# D.filter("type = 'StillImage'").groupBy("license","type").count().orderBy(desc("count")).show()
# df1 = 
# df.join(df2, df.name == df2.name, 'outer').select(df.name, df2.height).collect(

