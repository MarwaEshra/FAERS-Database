/*
This script calculate the confidence interval.
The calculation is based on the table which holds the PRR,ROR,IC and EBGM calculation for the relation between Drug name and PT name
for only 6 drugs which the main concern of the study:
- entrectinib
- lorlatinib
- brigatinib
- alectinib
- ceritinib
- crizotinib
*/

-- The row count is 4909
create table PT_prodai_case_Final_abcd_PRR_ROR_CI_3 TABLESPACE nother_space as
(

	select
		prod_ai as drug_name,
		PT,
		a1,
		b1,
		c1,
		d1,
		PRR,
		exp((ln(PRR))+(1.96*(sqrt((1.0/a1)-(1.0/(a1+b1))+(1.0/c1)+(1.0/(c1+d1)))))) as CI95plus_PRR,
		exp((ln(PRR))-(1.96*(sqrt((1.0/a1)-(1.0/(a1+b1))+(1.0/c1)+(1.0/(c1+d1)))))) as CI95minus_PRR,
		ROR,
		exp((ln(ROR))+(1.96*(sqrt((1.0/a1)+(1.0/(b1))+(1.0/c1)+(1.0/d1))))) as CI95plus_ROR,
		exp((ln(ROR))-(1.96*(sqrt((1.0/a1)+(1.0/(b1))+(1.0/c1)+(1.0/d1))))) as CI95minus_ROR,
		IC,
		exp((ln(IC)) + (1.96 * sqrt((1.0/a1)+(1.0/(b1))+(1.0/c1)+(1.0/d1)))) as CI95plus_IC,
		exp((ln(IC)) - (1.96 * sqrt((1.0/a1)+(1.0/(b1))+(1.0/c1)+(1.0/d1)))) as CI95minus_IC,
		EBGM,
		exp((ln(EBGM)) + (1.96 * sqrt((1.0/a1)+(1.0/(b1))+(1.0/c1)+(1.0/d1)))) CI95plus_EBGM,
		exp((ln(EBGM)) - (1.96 * sqrt((1.0/a1)+(1.0/(b1))+(1.0/c1)+(1.0/d1)))) CI95minus_EBGM
	from pt_prodai_case_Final_abcd_prr_ror_2
);

