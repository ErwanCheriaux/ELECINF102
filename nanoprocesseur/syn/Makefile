 SYN_FILE = $(TOP).sof
 CHICKEN_FILE = chicken.sof
 VERIF_FILE = verif.sof
 export PROG_FILE =  $(shell pwd)/$(SYN_FILE)

# répertoire des fichiers source
vpath %.sv ../src 

.PHONY:clean program verif chicken

QUARTUS_CMD = @quartus_sh -t DoQuartus.tcl -src_dir ../src -sv_dir ../src -revision

all:verif

verif: $(SYNTHESE_FILES)
	cp ../assembleur/verif.lst ../assembleur/ram.lst
	$(QUARTUS_CMD) verif | grep -i error

chicken: $(SYNTHESE_FILES) 
	cp ../assembleur/chicken.lst ../assembleur/ram.lst
	$(QUARTUS_CMD) chicken | grep -i error


prg_chicken:$(CHICKEN_FILE)        
	@echo "#########################################"
	@echo "####### Programmation de la carte #######"
	@echo "########### Programme musical ###########"
	@quartus_pgm -c DE-SoC  -m JTAG -oP\;$<@2 -oS\;SOCVHPS@1

prg_verif:$(VERIF_FILE)        
	@echo "#########################################"
	@echo "####### Programmation de la carte #######"
	@echo "############ Programme TEST #############"
	@quartus_pgm -c DE-SoC  -m JTAG -oP\;$<@2 -oS\;SOCVHPS@1

clean:
	-rm -rf db *.jdi *.qsf *.qpf *.sof *.pof *.rpt *.summary *.done *.pin *.smsg *.qws ram.lst incremental_db
	-rm -f c5_pin_model_dump.txt
