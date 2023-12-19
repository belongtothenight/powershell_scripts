# Ref: https://tex.stackexchange.com/questions/87319/how-to-run-tex-from-the-command-line-interface-in-linux
# Ref: https://stackoverflow.com/questions/49384301/make-clean-failed-in-windows

# Usage
# 1. make <file.pdf> -B
# 2. make clean; make <file.pdf>

ifeq ($(OS),Windows_NT) 
RM = del /Q /F
CP = copy /Y
ifdef ComSpec
SHELL := $(ComSpec)
endif
ifdef COMSPEC
SHELL := $(COMSPEC)
endif
else
RM = rm -rf
CP = cp -f
endif

INFO = [INFO]

# Generate PDF
%.pdf : %.tex
	${MAKE} clean
	@echo ${INFO} Generating PDF
	@echo ${INFO} PDFLaTeX running...
	pdflatex $< -quiet
	@echo ${INFO} $< generated.
	${MAKE} clean

# Clean up
clean:
	@echo ${INFO} Cleaning up...
	-$(RM) *.aux
	-$(RM) *.dvi
	-$(RM) *.lof
	-$(RM) *.log
	-$(RM) *.lot
	-$(RM) *.toc
	-$(RM) *.out
	-$(RM) *.synctex.gz
