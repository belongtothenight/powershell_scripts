# Usage
# 1. make <file.pdf> -B
# 2. make clean; make <file.pdf>

# Notice
# 1. First execution won't properly generate PDF, second execution is needed
# 2. Don't use `make clean` repeatly, temporary files are necessary for PDF generation

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
	@echo ${INFO} Generating PDF
	@echo ${INFO} PDFLaTeX running (generating temp files)...
	pdflatex $< 
	@echo ${INFO} BibTeX running...
	bibtex "$(basename $<)" -quiet
	@echo ${INFO} LaTex running...
	latex $< -quiet
	@echo ${INFO} PDFLateX running (generating PDF)...
	pdflatex $< -quiet
	@echo ${INFO} $< PDF generated.

# Clean up
clean:
	@echo ${INFO} Cleaning up...
	@$(RM) *.aux
	@$(RM) *.dvi
	@$(RM) *.lof
	@$(RM) *.log
	@$(RM) *.lot
	@$(RM) *.toc
	@$(RM) *.out
	@$(RM) *.synctex.gz
	@$(RM) *.ilg
	@$(RM) *.ind
	@$(RM) *.bbl
	@$(RM) *.blg
	@$(RM) *.pdf
