*27.01.21
*annie.herbert@bristol.ac.uk
*Importing data and saving with vars in the right order for supp tables

import excel "A:\Quant\P2 - Profiles\JIPV\results\fig2.xlsx", sheet("impact") firstrow clear

encode(outcome), gen(outcome_order2)
label list outcome_order2
/*

outcome_order2:
           1 Affected work/studies
           2 Angry/annoyed
           3 Anxious
           4 Depressed
           5 Drank more
           6 Sad
           7 Upset/unhappy

*/

recode outcome_order2 (2=1) (6=2) (7=3) (4=4) (1=5) (3=6) (5=7), gen(outcome_order)
sort sex class_no outcome_order
order sex class_paper outcome prob se
*Paste into yellow highlighted section in Excel file 'tables', sheet 'Table S2'

*Now perpetration
import excel "A:\Quant\P2 - Profiles\JIPV\results\fig3.xlsx", sheet("perp") firstrow clear
encode(outcome), gen(outcome_order2)
label list outcome_order2
/*
outcome_order2:
           1 Coercive Psych
           2 Explicit Psych
           3 Physical
           4 Sexual

*/

recode outcome_order2 (2=1) (1=2) (3=3) (4=4), gen(outcome_order)
sort sex class_no outcome_order
order sex class_paper outcome prob se
*Paste into yellow highlighted section in Excel file 'tables', sheet 'Table S3'