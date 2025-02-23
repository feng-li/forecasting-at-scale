all: slides zip sync

slides:
	jupyter-nbconvert **/L*.ipynb  --to slides  --SlidesExporter.reveal_theme=solarized --SlidesExporter.reveal_scroll=True --SlidesExporter.reveal_transition=fade --SlidesExporter.reveal_width=1600 --SlidesExporter.reveal_height=900

html:
	jupyter-nbconvert **/**.ipynb  --to html

zip:
	git archive --output=bdcf-slides.zip HEAD

sync:
	rsync -av --delete-excluded --prune-empty-dirs --include '*/' --include '*slides.zip' --include 'bdcf-data.zip' --include 'data/*' --include '*.ipynb' --include '*.slides.html' --include 'figures/*' --exclude '*' .  ${HOME}/nextcloud/feng.li/bdcf/
