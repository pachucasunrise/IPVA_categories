MPlus (.INP), Stata (.do), and R (.R) code pertaining to the paper 'Categories of intimate partner violence and abuse (IPVA) among young women and men: 
a Latent Class Analysis of psychological, physical, and sexual victimisation and perpetration in a UK birth cohort', 
Authors: Annie Herbert, Abigail Fraser, Laura D Howe, Eszter Szilassy, Maria Barnes, Gene Feder, Christine Barter, Jon Heron

*February 2021

Short abstract: In the UK, around one-third of young people are exposed to IPVA by 21 years old. However,
types of IPVA victimisation in this population (psychological, physical, sexual), and their
relationship with impact and perpetration are poorly understood. 
We carried out a latent class analysis, where we categorised IPVA by types/frequency of victimisation, 
and then assigned individuals to their most probable class. Within these classes, we then estimated risks 
of reported: 1) types of negative impacts (sad, upset/unhappy, anxious, depressed, affected work/studies, 
angry/annoyed, drank/took drugs more); 2) types/frequency of perpetration. Victimisation responses were 
well represented by five classes, including three apparent in both sexes: No-low victimisation 
(characterised by low probabilities of all types of victimisation; average probabilities of women and men 
belonging to this class were 82% and 70%); Mainly psychological (15% and 12%); Psychological & physical 
victimisation (4% and 7%), and two classes that were specific to women: Psychological & sexual (7%); 
Multi-victimisation (frequent victimisation for all three types; 4%). In women, all types of negative 
impact were most common in the Psychological & sexual and Multi-victimisation classes; for men, the
Psychological & physical class. In women, all types of perpetration were most common for the 
Mainly psychological, Psychological & physical, and Multi-victimisation classes; in men, the
Mainly psychological and Psychological & physical classes.

The files are numbered in the order that they should be run. 
1_ipva_vict_lca_diagnostics_automate.R : fits models across the 8 IPVA victimisation items for different numbers of classes (ranging from 1-6 classes; Step 1 of the 3-step LCA)
Probabilities are taken from the resulting .OUT files and placed in an Excel sheet, to produce Figure 1.
1_ipva_vict_lca_diagnostics_automate.R also places diagnostics in a text file, used to create Supp Table S1.
- 'victimisation_lca_models.txt' and 'victimisation_lca_models - blrt.txt' are required to run 1_ipva_vict_lca_diagnostics_automate.R

2_ipva_vict_3class_boys_savedata.INP and 3_ipva_vict_5class_boys_savedata.INP saves class probabilities from the user-selected class solutions (3 in men, 5 in women) 
and saves these into text files 

4_create_statadata_modal_assignment.do assigns each individual to their modal class (Step 2 of the 3-step LCA), and resaves as a Stata .dta file.

5_boys and impact.INP, 6_boys and perp.INP, 7_girls and impact.INP, 8_girls and perp.INP, estimate probabilities of the impact and perpetration outcomes for men and women (Step 3 of the 3-step LCA)
Probabilities are taken from the resulting .OUT files and places in an Excel sheet.

9_supp_tables_S2_S3.do takes these data and puts sex, classes, and outcomes in the right order to produce Supp Tables S2 and S3.

10_figs_2_3 produces the spider plot of impact outcomes (Figure 2) and dot-whisker plot of perpetration outcomes (Figure 3).

*May 2022
The paper has now been published in J Interpersonal Violence: https://journals.sagepub.com/doi/full/10.1177/08862605221087708
