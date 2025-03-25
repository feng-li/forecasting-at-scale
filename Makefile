all: slides zipgit zipcode sync

slides:
	jupyter-nbconvert **/L*.ipynb  --to slides  --SlidesExporter.reveal_theme=solarized --SlidesExporter.reveal_scroll=True --SlidesExporter.reveal_transition=fade --SlidesExporter.reveal_width=1366 --SlidesExporter.reveal_height=768

html:
	jupyter-nbconvert **/**.ipynb  --to html

zipgit:
	git archive --output=bdcf-slides_data.zip HEAD

zipcode:
	zip -r bdcf-slides.zip . -x "*.git*" "data/*" ".venv/*"

sync:
	rsync -av --delete-excluded --prune-empty-dirs --include '*/' --include '*slides.zip' --include 'data/*' --include '*.ipynb' --include '*.slides.html' --include 'figures/*' --exclude '*' .  ${HOME}/nextcloud/feng.li/bdcf/
