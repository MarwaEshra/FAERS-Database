/*
The calculation is based on the table which holds the ABCD calculation for the relation between Drug name and SOC
for only 6 drugs which the main concern of the study:
- entrectinib
- lorlatinib
- brigatinib
- alectinib
- ceritinib
- crizotinib
*/

-- The row count is 158
create table soc_prodai_case_Final_abcd_prr_ror_2 TABLESPACE nother_space as
(
	select
		prod_ai,
		soc_code,
		a1,
		b1,
		c1,
		d1,
		(((a1)/((a1)+(b1)))/((c1)/((c1)+(d1)))) as PRR,
		(((a1)/(b1))/((c1)/(d1))) as ROR,
		IC,
		((a1/(a1+b1))/((a1+c1)/(a1+b1+c1+d1))) as EBGM
	from 
	(
		SELECT 
		  	CAST(a1 as FLOAT) as a1, 
			CAST(b1 as FLOAT) as b1,
			CAST(c1 as FLOAT) as c1,
			CAST(d1 as FLOAT) as d1,
			log(2,a1)+log(2,(a1+b1+c1+d1))+log(2,(a1 + c1))+log(2,(a1 + b1)) AS IC,
			prod_ai,
			soc_code
		FROM soc_prodai_case_Final_abcd_1 WHERE lower(prod_ai) in ('entrectinib','lorlatinib', 'brigatinib', 'alectinib', 'ceritinib', 'crizotinib')
	) X
);
