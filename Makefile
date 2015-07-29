## Markdown extension (e.g. md, markdown, mdown).
MEXT = md
 
## All markdown files in the working directory, except README.md
SRC = $(filter-out README.md, $(wildcard *.$(MEXT)))
 
## Location of Pandoc support files.
PREFIX = %userprofile%\AppData\Roaming\pandoc
 
## Location of your working bibliography file
BIB = C:/MyTemp/Dropbox/Bibtex/library.bib
 
## CSL stylesheet (located in the csl folder of the PREFIX directory).
CSL = chicago-author-date
LOCALE = fi-FI
 
## Additional reveal.js options
THEME = serif
TRANSITION = fade
 
## Note that all the output directories need to exist or make won't work
 
## Output directory for lectures
LECTURES = W:/rajattu/esitykset
 
## Output directory for lecture notes
NOTES = notes
 
## Output directory for lecture notes as pdfs
PDFNOTES = pdfnotes
 
PDFS=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
REVEALJS=$(SRC:.md=.revealjs.html)
 
all:	$(PDFS) $(HTML) $(REVEALJS)
 
pdf:	$(PDFS)
html:	$(HTML)
revealjs:	$(REVEALJS)
 
%.revealjs.html: %.md
	pandoc -s -S --self-contained -t revealjs --filter pandoc-citeproc --bibliography=$(BIB) --variable=locale:$(LOCALE) --variable=theme:$(THEME) --include-in-header=custom.css --variable=transition:$(TRANSITION) -o $(LECTURES)/$@ $<
 
%.html:	%.md
	pandoc -S -t html5 --filter pandoc-citeproc --csl=$(PREFIX)/csl/$(CSL).csl --bibliography=$(BIB) -o $(NOTES)/$@ $<
 
%.pdf:	%.md
	pandoc -S --template=$(PREFIX)/templates/latex.template --filter pandoc-citeproc --csl=$(PREFIX)/csl/$(CSL).csl --bibliography=$(BIB) -o $(PDFNOTES)/$@ $<
