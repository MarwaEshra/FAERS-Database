/*
This script calcualte some basic statistcs around some demographs like weight, age,gender and reporter occupation for the following drugs:
- entrectinib
- lorlatinib
- brigatinib
- alectinib
- ceritinib
- crizotinib
*/

--- This table calulate the count of events per each drug from the mentioned 6 drugs.
--- The row count for the table is 6
CREATE TABLE TOTAL_Events_PER_DRUG_Final TABLESPACE nother_space as
(
	SELECT 
	prod_ai,
	count(*) Total_number
	FROM soc_prodai_case_Final
	WHERE lower(prod_ai) in ('entrectinib','lorlatinib', 'brigatinib', 'alectinib', 'ceritinib', 'crizotinib')
	GROUP BY 1
);

--- This table get the mean and standard deviation for the age of the patient per each drug from the concerned 6 drugs.
--- The row count is 6
CREATE TABLE AGE_MEAN_STD_PER_DRUG_Final TABLESPACE nother_space as
(
SELECT prod_ai,avg(n_age),stddev_pop(n_age)
FROM soc_prodai_case_Final base
INNER JOIN demo_final demo
	ON demo.primaryid = base.primaryid
WHERE lower(prod_ai) in ('entrectinib','lorlatinib', 'brigatinib', 'alectinib', 'ceritinib', 'crizotinib') AND new_age_cod='YR'
GROUP BY prod_ai
);

--- This table get the mean and standard deviation for the weight of the patient per each drug from the concerned 6 drugs.
--- The row count is 6
CREATE TABLE WEIGHTS_KG_MEAN_STD_PER_DRUG_Final TABLESPACE nother_space as
(
SELECT prod_ai,
	avg(n_w8/1000.0),
	stddev_pop(n_w8/1000.0)
FROM soc_prodai_case_Final base
INNER JOIN demo_final demo
ON demo.primaryid = base.primaryid
WHERE lower(prod_ai) in ('entrectinib','lorlatinib', 'brigatinib', 'alectinib', 'ceritinib', 'crizotinib') 
	AND new_w8_cod='grams'
GROUP BY prod_ai
);

--- This table get the percentage of each gender patient per each drug from the concerned 6 drugs.
--- The row count is 6
CREATE TABLE GENDER_PERCENTAGE_PER_DRUG_Final TABLESPACE nother_space as
(
SELECT prod_ai,
		SUM(CASE WHEN new_sex = 'F' THEN 1 ELSE 0 END)/CAST(COUNT(*)  AS FLOAT) * 100 AS FEMALE_PER,
	SUM(CASE WHEN new_sex = 'F' THEN 1 ELSE 0 END) FEMALES_CNT,
		SUM(CASE WHEN new_sex = 'M' THEN 1 ELSE 0 END)/CAST(COUNT(*)  AS FLOAT) * 100 AS MALE_PER,
	SUM(CASE WHEN new_sex = 'M' THEN 1 ELSE 0 END) MALES_CNT,
		SUM(CASE WHEN new_sex is null THEN 1 ELSE 0 END)/CAST(COUNT(*)  AS FLOAT) * 100 AS UNKNOWN_PRE,
	SUM(CASE WHEN new_sex is null THEN 1 ELSE 0 END) UNKNOWN_CNT
FROM soc_prodai_case_Final base
INNER JOIN demo_final demo
ON demo.primaryid = base.primaryid
WHERE lower(prod_ai) in ('entrectinib','lorlatinib', 'brigatinib', 'alectinib', 'ceritinib', 'crizotinib')
GROUP BY prod_ai
);

--- This table get the percentage of each reporter occupation per each drug from the concerned 6 drugs.
CREATE TABLE OCCP_PERCENTAGE_PER_DRUG_Final TABLESPACE nother_space as
(
SELECT prod_ai,
	occp_cod,
	count(*)/CAST(total as FLOAT) * 100 OCCP_PER,
	count(*) OCCP_CNT
FROM
	(
		SELECT prod_ai,
			CASE WHEN occp_cod IS NULL THEN 'UNKNOWN' ELSE OCCP_COD END OCCP_COD,
			COUNT(*) OVER(PARTITION BY prod_ai) total
		FROM soc_prodai_case_Final base
		INNER JOIN demo_final demo
			ON demo.primaryid = base.primaryid
		WHERE lower(prod_ai) in ('entrectinib','lorlatinib', 'brigatinib', 'alectinib', 'ceritinib', 'crizotinib')
	) X
GROUP BY prod_ai,occp_cod,total
);


--- This table calculate the percentage of drug contribution in the final medical outcome:
--- The count of the rows 81

CREATE TABLE SIGN_Outc_PERCENT_PER_DRUG_Final TABLESPACE nother_space as
(
SELECT prod_ai,
	soc_code,
	OUTC_CODE,
	count(*)/CAST(total as FLOAT) * 100 OUTC_PER,
	count(*) OUTC_CNT
FROM
	(
		SELECT sign_base.drug_name as prod_ai,
			sign_base.soc_code,
			CASE WHEN outc.outc_cod IS NULL THEN 'UNKNOWN' ELSE outc.outc_cod END OUTC_CODE,
			COUNT(*) OVER(PARTITION BY prod_ai) total
		FROM significant_prr_ror_Final sign_base
		inner join soc_prodai_case_Final base
			on sign_base.drug_name = base.prod_ai and sign_base.soc_code = base.soc_code
		INNER JOIN outc_final outc
			ON outc.primaryid = base.primaryid
	) X
GROUP BY prod_ai, soc_code, OUTC_CODE, total
);

--- Table to hold dataset to be used in Anova calculation
--- Count of the rows 58886
CREATE TABLE anove_dataset TABLESPACE nother_space as
(

	SELECT 
	prod_ai,
	demo.primaryid,
	case when new_age_cod='YR' then n_age else null end as age,
	case when new_w8_cod='grams' then n_w8 else null end as w8
	
FROM soc_prodai_case_Final base
INNER JOIN demo_final demo
	ON demo.primaryid = base.primaryid
WHERE lower(prod_ai) in ('entrectinib','lorlatinib', 'brigatinib', 'alectinib', 'ceritinib', 'crizotinib')	
);


