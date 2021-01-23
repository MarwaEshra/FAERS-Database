/*
The rows count for the base table which holds the relation between Drug name and PT name is 45528187
*/

-- Create statement for temp table which calculate "A" value
-- The count of the rows 2744972
create table PT_prodai_case_Final_a TABLESPACE nother_space as
(
	select
		prod_ai,
		pt,
		count(*) as a1
	from soc_prodai_case_Final
	--WHERE pt is not null
	group by 1,2
);

-- Create statement for temp table which calculate a variable "g1" which will be used in "D" calcualtion.
-- The count of the rows 20209
create table pt_sum_prodai_case_Final_g1 TABLESPACE nother_space as
(
	select
		pt,
		count(*) as g1
	from soc_prodai_case_Final
	--WHERE pt is not null
	group by 1
);

-- Create statement for temp table which calculate a variable "e1" which will be used in "B" calcualtion.
-- The count of the rows 32071
create table prodai_case_Final_sum TABLESPACE nother_space as
(
	select
		prod_ai,
		count(*) as e1
	from soc_prodai_case_Final
	group by 1
);

-- Create statement for  table which "ABCD" by utilizing the above temp tables
-- A is a1, B is b1 , C is c1, D is D1
-- The count of the rows 2744972

create table pt_prodai_case_Final_abcd_1 TABLESPACE nother_space as
(
	select 
	base.prod_ai,
	base.pt,
	base.a1,
	d_s.e1,	--drug total count
	ss.g1,	--pt total count
	--case when (e1 - a1) >0 then (e1 - a1) else 0.
	(e1 - a1) as b1,
	(45528187 - e1)	as f1,
	(g1 - a1) as c1,
	(45528187 - g1)	as h1,
	((45528187 - g1) - (e1 - a1)) as d1,	--h1-b1
	((45528187 - e1 ) - (g1 - a1)) as d2,
	case when ((45528187 - g1) - (e1 - a1)) = ((45528187 - e1)-(g1 - a1)) then 'TRUE'
	else 'FALSE'
	end as verify	
	
	from PT_prodai_case_Final_a				as base
	left join prodai_case_Final_sum			as d_s
		on base.prod_ai = d_s.prod_ai
	left join pt_sum_prodai_case_Final_g1 		as ss
		on base.pt = ss.pt 
);

/*
Some quality and sanity checks on the ABCD table
*/
select * from pt_prodai_case_Final_abcd_1
where verify = 'False';
--returns 0

select * from pt_prodai_case_Final_abcd_1
where a1 = 0 ;
--returns 0

select * from pt_prodai_case_Final_abcd_1
where a1 = 0 ;
--returns 0

select * from pt_prodai_case_Final_abcd_1
where b1 = 0
and prod_ai in ('crizotinib', 'entrectinib', 'lorlatinib', 'brigatinib', 'alectinib', 'ceritinib');
--returns 0

select * from pt_prodai_case_Final_abcd_1
where (c1 = 0 or d1=0)
and prod_ai in ('crizotinib', 'entrectinib', 'lorlatinib', 'brigatinib', 'alectinib', 'ceritinib');
--1 row returned
--"ceritinib"	"spinal meningioma malignant"	2	11248	2	11246	45516939	0	45528185	45516939	45516939	"TRUE"
