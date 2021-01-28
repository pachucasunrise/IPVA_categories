*28.01.21
*Takes MPlus outputs for 3 classes in men and 5 classes in women, and assigns each to their modal class. Resaves all as a Stata dataset.

cd "A:/Quant/P2 - Profiles/JIPV/results"

import delimited "3class_males.txt", delimiter(space, collapse) clear 

/*
    Latent Classes
       1         39.86434          0.03482
       2        170.47709          0.14889
       3        934.65857          0.81630
	   */
	   
drop v1
renvars v* / v_emo_co v_emo_ex v_phys1 v_phys2 ///
     v_sex1_c v_sex1_f    ///
     p_emo_co p_emo_ex p_phys p_sex ///
     neg_sum ///
     imp5020 imp5021 imp5022 imp5024 imp5025 imp5028 imp5029 p1 p2 p3 modc
	 
save "3class_males.dta", replace

 

import delimited "5class_females.txt", delimiter(space, collapse) clear 

/*
    Latent Classes
       1        139.39074          0.06550
       2         91.50942          0.04300
       3        154.85030          0.07277
       4        250.72860          0.11782
       5       1491.52094          0.70090
	   */
	   
drop v1
renvars v* / v_emo_co v_emo_ex v_phys1 v_phys2 ///
       v_sex1_c v_sex1_f v_sex2_c v_sex2_f ///
       p_emo_co p_emo_ex p_phys p_sex ///
       neg_sum ///
       imp5020 imp5021 imp5022 imp5024 imp5025 imp5028 imp5029 ///
       p1 p2 p3 p4 p5 modc
	 
save "5class_females.dta", replace

	 


