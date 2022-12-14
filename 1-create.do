****Create and clean Redline Project analytical data***

***import nhgis data 2009-2013***
clear all
import delimited "nhgis0006_ds202_20135_tract_E.csv", varnames(1) rowrange(3) 

save "nhgis_2009-13.dta", replace
clear all

clear all
import delimited "nhgis0006_ds245_20195_tract_E.csv", varnames(1) rowrange(3) 


keep gisjoin stusab state statea county countya tracta geoid

merge 1:1 gisjoin state statea county countya tracta using "nhgis_2009-13.dta"

rename _merge geoidmerge

save "nhgis_2009-13_geoid.dta", replace

clear all
import delimited "nhgis0006_ds245_20195_tract_E.csv", varnames(1) rowrange(3) 

 
rename (amc3e001 amc3e002 amc3e003 amc3e004 amc3e005 amc3e006 amc3e007 amc3e008 amc3e009 amc3e010 amc3e011 amc3e012 amc3e013 amdle001 amdle002 amdle003 amdle004 amdle005 amdle006 amdle007 amdle008 amdle009 amdle010 amdle011 amgre001 amgre002 amgre003 amgre004 amgre005 amgre006 amgre007 amgte001 amgte002 amgte003 amgze001 amgze002 amgze003 amg0e001 amg0e002 amg0e003 amhde001 amhde002 amhde003 amhde004 amhde005 amhde006 amhde007 amhde008 amhde009 amhde010 amhde011 amhde012 amhde013 amhde014 amhde015 amhde016 amhde017 amhde018 amhde019 amhde020 amhde021 amhde022 amhde023 amhde024 amhde025 amhde026 amhde027 amhde028 amhde029 amlne001 amlne002 amlne003 amlne004 amlne005 amlne006 amlne007 amlne008 amlne009 amlne010 amlte001 amlte002 amlte003 amlte004 amlte005 amlte006 amlte007 amlte008 amlte009 amlte010 amlue001 amlue002 amlue003 amlue004 amlue005 amlue006 amlue007 amlue008 amlue009 amlue010 amlve001 amlve002 amlve003 amlve004 amlve005 amlve006 amlve007 amlve008 amlve009 amlve010 amlve011 amlve012 amlve013 amlve014 amlve015 amlve016 amlve017 amlve018 amlve019 amlve020 amlve021 amlve022 amlve023 amlve024 amlve025 amlve026 amlve027 amlve028 amlve029 amlve030 amlve031 amlve032 amlve033 amlve034 amlve035 amlve036 amlve037 amlve038 amlve039 amlve040 amlve041 amlve042 amlve043 amlve044 amlve045 amlve046 amlve047 amlve048 amlve049 amlve050 amlve051 amlve052 amlve053 amlve054 amlve055 amlve056 amlve057 amlwe001 amlwe002 amlwe003 amlwe004 amlwe005 amlwe006 amlwe007 amlwe008 amlwe009 amlwe010 amlwe011 amlwe012 amlwe013 amlwe014 amlwe015 amlwe016 amlwe017 amlwe018 amlwe019 amlwe020 amlwe021 amlwe022 amlwe023 amlwe024 amlwe025 amlwe026 amlwe027 amlwe028 amlwe029 amlwe030 amlwe031 amlwe032 amlwe033 amlwe034 amlwe035 amlwe036 amlwe037 amlwe038 amlwe039 amlwe040 amlwe041 amlwe042 amlwe043 amlwe044 amlwe045 amlwe046 amlwe047 amlwe048 amlwe049 amlwe050 amlwe051 amlwe052 amlwe053 amlwe054 amlwe055 amlwe056 amlwe057 amlze001 amlze002 amlze003 amlze004 amlze005 amlze006 amlze007 amlze008 amlze009 amlze010 amlze011 amlze012 amlze013 amlze014 amlze015 amlze016 amlze017 amlze018 amlze019 amlze020 amlze021 aml0e001 aml0e002 aml0e003 aml0e004 aml0e005 aml0e006 aml0e007 aml0e008 aml0e009 aml0e010 aml0e011 aml0e012 aml0e013 aml0e014 aml0e015 aml0e016 aml0e017 aml0e018 aml0e019 aml0e020 aml0e021 aml7e001 aml7e002 aml7e003 aml7e004 aml7e005 aml7e006 aml7e007 aml7e008 aml7e009 aml7e010 aml7e011 aml7e012 aml7e013 aml7e014 aml7e015 aml7e016 aml7e017 aml7e018 aml7e019 aml7e020 aml7e021 aml7e022 aml7e023 aml7e024 aml7e025 aml7e026 ammbe001 ammbe002 ammbe003 ammbe004 ammbe005 ammbe006 ammbe007 ammbe008 ammbe009 ammbe010 ammbe011 ammbe012 ammbe013 ammbe014 ammbe015 ammbe016 ammbe017 ammbe018 ammbe019 ammbe020 ammbe021 ammbe022 ammbe023 ammbe024 ammbe025 ammbe026 ammbe027 ammbe028 ammbe029 ammbe030 ammbe031 ammbe032 ammbe033 ammbe034 ammbe035 ammbe036 ammbe037 ammbe038 ammbe039 ammbe040 ammbe041 ammbe042 ammbe043 ammce001 ammce002 ammce003 ammce004 ammce005 ammce006 ammce007 ammce008 ammce009 ammce010 ammce011 ammce012 ammce013 ammce014 ammce015 ammce016 ammce017) (uxke001 uxke002 uxke003 uxke004 uxke005 uxke006 uxke007 uxke008 uxke009 uxke010 uxke011 uxke012 uxke013 ux2e001 ux2e002 ux2e003 ux2e004 ux2e005 ux2e006 ux2e007 ux2e008 ux2e009 ux2e010 ux2e011 u0de001 u0de002 u0de003 u0de004 u0de005 u0de006 u0de007 u0fe001 u0fe002 u0fe003 u0le001 u0le002 u0le003 u0me001 u0me002 u0me003 u00e001 u00e002 u00e003 u00e004 u00e005 u00e006 u00e007 u00e008 u00e009 u00e010 u00e011 u00e012 u00e013 u00e014 u00e015 u00e016 u00e017 u00e018 u00e019 u00e020 u00e021 u00e022 u00e023 u00e024 u00e025 u00e026 u00e027 u00e028 u00e029 u3le001 u3le002 u3le003 u3le004 u3le005 u3le006 u3le007 u3le008 u3le009 u3le010 u3re001 u3re002 u3re003 u3re004 u3re005 u3re006 u3re007 u3re008 u3re009 u3re010 u3se001 u3se002 u3se003 u3se004 u3se005 u3se006 u3se007 u3se008 u3se009 u3se010 u3te001 u3te002 u3te003 u3te004 u3te005 u3te006 u3te007 u3te008 u3te009 u3te010 u3te011 u3te012 u3te013 u3te014 u3te015 u3te016 u3te017 u3te018 u3te019 u3te020 u3te021 u3te022 u3te023 u3te024 u3te025 u3te026 u3te027 u3te028 u3te029 u3te030 u3te031 u3te032 u3te033 u3te034 u3te035 u3te036 u3te037 u3te038 u3te039 u3te040 u3te041 u3te042 u3te043 u3te044 u3te045 u3te046 u3te047 u3te048 u3te049 u3te050 u3te051 u3te052 u3te053 u3te054 u3te055 u3te056 u3te057 u3ue001 u3ue002 u3ue003 u3ue004 u3ue005 u3ue006 u3ue007 u3ue008 u3ue009 u3ue010 u3ue011 u3ue012 u3ue013 u3ue014 u3ue015 u3ue016 u3ue017 u3ue018 u3ue019 u3ue020 u3ue021 u3ue022 u3ue023 u3ue024 u3ue025 u3ue026 u3ue027 u3ue028 u3ue029 u3ue030 u3ue031 u3ue032 u3ue033 u3ue034 u3ue035 u3ue036 u3ue037 u3ue038 u3ue039 u3ue040 u3ue041 u3ue042 u3ue043 u3ue044 u3ue045 u3ue046 u3ue047 u3ue048 u3ue049 u3ue050 u3ue051 u3ue052 u3ue053 u3ue054 u3ue055 u3ue056 u3ue057 u3xe001 u3xe002 u3xe003 u3xe004 u3xe005 u3xe006 u3xe007 u3xe008 u3xe009 u3xe010 u3xe011 u3xe012 u3xe013 u3xe014 u3xe015 u3xe016 u3xe017 u3xe018 u3xe019 u3xe020 u3xe021 u3ye001 u3ye002 u3ye003 u3ye004 u3ye005 u3ye006 u3ye007 u3ye008 u3ye009 u3ye010 u3ye011 u3ye012 u3ye013 u3ye014 u3ye015 u3ye016 u3ye017 u3ye018 u3ye019 u3ye020 u3ye021 u33e001 u33e002 u33e003 u33e004 u33e005 u33e006 u33e007 u33e008 u33e009 u33e010 u33e011 u33e012 u33e013 u33e014 u33e015 u33e016 u33e017 u33e018 u33e019 u33e020 u33e021 u33e022 u33e023 u33e024 u33e025 u33e026 u35e001 u35e002 u35e003 u35e004 u35e005 u35e006 u35e007 u35e008 u35e009 u35e010 u35e011 u35e012 u35e013 u35e014 u35e015 u35e016 u35e017 u35e018 u35e019 u35e020 u35e021 u35e022 u35e023 u35e024 u35e025 u35e026 u35e027 u35e028 u35e029 u35e030 u35e031 u35e032 u35e033 u35e034 u35e035 u35e036 u35e037 u35e038 u35e039 u35e040 u35e041 u35e042 u35e043 u36e001 u36e002 u36e003 u36e004 u36e005 u36e006 u36e007 u36e008 u36e009 u36e010 u36e011 u36e012 u36e013 u36e014 u36e015 u36e016 u36e017)



drop aitscea regiona divisiona cousuba placea concita aianhha res_onlya trusta aihhtli aits anrca cbsaa csaa metdiva memi nectaa cnectaa nectadiva uaa cdcurra sldua sldla zcta5a submcda sdelma sdseca sdunia ur pci puma5a bttra

foreach x in uxke001 uxke002 uxke003 uxke004 uxke005 uxke006 uxke007 uxke008 uxke009 uxke010 uxke011 uxke012 uxke013 ux2e001 ux2e002 ux2e003 ux2e004 ux2e005 ux2e006 ux2e007 ux2e008 ux2e009 ux2e010 ux2e011 u0de001 u0de002 u0de003 u0de004 u0de005 u0de006 u0de007 u0fe001 u0fe002 u0fe003 u0le001 u0le002 u0le003 u0me001 u0me002 u0me003 u00e001 u00e002 u00e003 u00e004 u00e005 u00e006 u00e007 u00e008 u00e009 u00e010 u00e011 u00e012 u00e013 u00e014 u00e015 u00e016 u00e017 u00e018 u00e019 u00e020 u00e021 u00e022 u00e023 u00e024 u00e025 u00e026 u00e027 u00e028 u00e029 u3le001 u3le002 u3le003 u3le004 u3le005 u3le006 u3le007 u3le008 u3le009 u3le010 u3re001 u3re002 u3re003 u3re004 u3re005 u3re006 u3re007 u3re008 u3re009 u3re010 u3se001 u3se002 u3se003 u3se004 u3se005 u3se006 u3se007 u3se008 u3se009 u3se010 u3te001 u3te002 u3te003 u3te004 u3te005 u3te006 u3te007 u3te008 u3te009 u3te010 u3te011 u3te012 u3te013 u3te014 u3te015 u3te016 u3te017 u3te018 u3te019 u3te020 u3te021 u3te022 u3te023 u3te024 u3te025 u3te026 u3te027 u3te028 u3te029 u3te030 u3te031 u3te032 u3te033 u3te034 u3te035 u3te036 u3te037 u3te038 u3te039 u3te040 u3te041 u3te042 u3te043 u3te044 u3te045 u3te046 u3te047 u3te048 u3te049 u3te050 u3te051 u3te052 u3te053 u3te054 u3te055 u3te056 u3te057 u3ue001 u3ue002 u3ue003 u3ue004 u3ue005 u3ue006 u3ue007 u3ue008 u3ue009 u3ue010 u3ue011 u3ue012 u3ue013 u3ue014 u3ue015 u3ue016 u3ue017 u3ue018 u3ue019 u3ue020 u3ue021 u3ue022 u3ue023 u3ue024 u3ue025 u3ue026 u3ue027 u3ue028 u3ue029 u3ue030 u3ue031 u3ue032 u3ue033 u3ue034 u3ue035 u3ue036 u3ue037 u3ue038 u3ue039 u3ue040 u3ue041 u3ue042 u3ue043 u3ue044 u3ue045 u3ue046 u3ue047 u3ue048 u3ue049 u3ue050 u3ue051 u3ue052 u3ue053 u3ue054 u3ue055 u3ue056 u3ue057 u3xe001 u3xe002 u3xe003 u3xe004 u3xe005 u3xe006 u3xe007 u3xe008 u3xe009 u3xe010 u3xe011 u3xe012 u3xe013 u3xe014 u3xe015 u3xe016 u3xe017 u3xe018 u3xe019 u3xe020 u3xe021 u3ye001 u3ye002 u3ye003 u3ye004 u3ye005 u3ye006 u3ye007 u3ye008 u3ye009 u3ye010 u3ye011 u3ye012 u3ye013 u3ye014 u3ye015 u3ye016 u3ye017 u3ye018 u3ye019 u3ye020 u3ye021 u33e001 u33e002 u33e003 u33e004 u33e005 u33e006 u33e007 u33e008 u33e009 u33e010 u33e011 u33e012 u33e013 u33e014 u33e015 u33e016 u33e017 u33e018 u33e019 u33e020 u33e021 u33e022 u33e023 u33e024 u33e025 u33e026 u35e001 u35e002 u35e003 u35e004 u35e005 u35e006 u35e007 u35e008 u35e009 u35e010 u35e011 u35e012 u35e013 u35e014 u35e015 u35e016 u35e017 u35e018 u35e019 u35e020 u35e021 u35e022 u35e023 u35e024 u35e025 u35e026 u35e027 u35e028 u35e029 u35e030 u35e031 u35e032 u35e033 u35e034 u35e035 u35e036 u35e037 u35e038 u35e039 u35e040 u35e041 u35e042 u35e043 u36e001 u36e002 u36e003 u36e004 u36e005 u36e006 u36e007 u36e008 u36e009 u36e010 u36e011 u36e012 u36e013 u36e014 u36e015 u36e016 u36e017{
	destring(`x'), force replace
}

split geoid, p("US")

drop geoid geoid1 
rename geoid2 geoid

order geoid 

merge m:1 geoid using "rl_censustract.dta"
rename _merge noredline
gen in_rl=0
replace in_rl=1 if noredline==3
tab noredline in_rl

drop noredline

save "nhgis_2009-2019_rl_toclean.dta", replace

