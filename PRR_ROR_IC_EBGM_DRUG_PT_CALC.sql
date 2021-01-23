/*
The calculation is based on the table which holds the ABCD calculation for the relation between Drug name and PT name
for only 6 drugs which the main concern of the study:
- entrectinib
- lorlatinib
- brigatinib
- alectinib
- ceritinib
- crizotinib
*/

-- The row count is 4909
create table pt_prodai_case_Final_abcd_prr_ror_2 TABLESPACE nother_space as
(
	select
		prod_ai,
		pt,
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
			pt
		FROM pt_prodai_case_Final_abcd_1 WHERE lower(prod_ai) in ('entrectinib','lorlatinib', 'brigatinib', 'alectinib', 'ceritinib', 'crizotinib')
		AND c1 <> 0
		
	) X
);

