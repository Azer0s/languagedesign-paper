all:
	@$(MAKE) clear
	@$(MAKE) thesis

thesis:
	@echo
	@echo "\033[4m\033[1mBuilding thesis\033[0m"
	@echo
	@mkdir build
	@asciidoctor-pdf -r asciidoctor-mathematical -r asciidoctor-diagram src/main/asciidoc/language-design.adoc -a mathematical-format=svg
	@rm -rf src/main/asciidoc/.asciidoctor
	@rm src/main/asciidoc/*.svg
	@pdflatex -halt-on-error -output-directory build TitlePage.tex
	@mv src/main/asciidoc/language-design.pdf build/diplomathesis.pdf
	@pdftk build/diplomathesis.pdf cat 1-1 4-end output build/diplomathesis1.pdf
	@rm build/diplomathesis.pdf
	@pdftk build/TitlePage.pdf build/diplomathesis1.pdf cat output build/language-design.pdf
	@rm build/diplomathesis1.pdf
	@rm build/TitlePage.*
	@echo
	@echo "\033[4m\033[1mDone!\033[0m"
	@echo

clear:
	@echo
	@echo "\033[4m\033[1mClearing output folder\033[0m"
	@echo
	@rm -rf build/ || true
