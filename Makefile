render:
	quarto render
pdf:
	quarto render --to pdf
html:
	quarto render --to html
deploy:
	rsync -a -v --delete _book/ au78495@tildefiles.au.dk:public_html/NLM
	rsync -a -v --delete docker_r-wasm/output/repo au78495@tildefiles.au.dk:public_html/

publish: render deploy
