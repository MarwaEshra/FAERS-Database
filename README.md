# FAERS-Database
OpenSource FAERS Database Cleansing, Merging and Analysis



### Technologies used:
  1- Postgresql version 4.21

  2- Python



### Steps to understand this project:
  1- Business Understanding of needed research question and DB information

  2- Data Understanding of FAERS Database

  3- Importing since 2012 Q1 to 2020 Q2

  4- Merging Tables

  5- Removing Full Row Duplicates

  6- Data Quality Issues ex. Age

  7- Data Cleansing ex. Gender

  8- Data Engineering ex. Age_cod and age_grp

  9- Python to Extract meddra codes files into txt file

  10- Importing Meddra Codes and names

  11- Importing Soc codes and names

  12- Calculating 2 by 2 table information to get: A,B,C,D 

  13- Caulcation of ROR, PRR, IC, EBGM and CI95% for each of them.

  14- Visualization of Results.



##### The data of the FAERS belongs entirely to the FDA and can be accessed as open source from this website: 
https://fis.fda.gov/extensions/FPD-QDE-FAERS/FPD-QDE-FAERS.html  
the ASCII files contain the CSV data that we used delimited by a $ sign



##### The data of the MedDRA is not open source, however you can learn more about it from these website:
1- MedDRA official website:
https://www.meddra.org/ which has very easy presentation for its explanation found at:
https://meddra.org/sites/default/files/page/documents_insert/meddra_-_terminologies_coding.pdf

2- MedDRA dictionary in oracle: 
https://docs.oracle.com/health-sciences/argus-suite-821/AADMN/dictionaries.htm#AADMN694 

3- The online version of MedDRA:
http://bioportal.bioontology.org/ontologies/MEDDRA/?p=classes&conceptid=root

Because of MedDRA not being open source so we can only share that we used MedDRA version 22.1.



### Acknowledgements
Please cite this github and the following paper(s) if you use it in your work:



### Authors:
Marwa Eshra (https://eg.linkedin.com/in/marwa-eshra) (ORC ID: https://orcid.org/0000-0001-5600-1166)

Tariq Saeed (https://eg.linkedin.com/in/tariq-saeed-a5279613) (ORC ID: https://orcid.org/0000-0001-9774-0483)


