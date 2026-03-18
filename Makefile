all: slides zipall zipcode sync

slides:
	jupyter-nbconvert **/L*.ipynb  --to slides  --SlidesExporter.reveal_theme=solarized --SlidesExporter.reveal_scroll=True --SlidesExporter.reveal_transition=fade --SlidesExporter.reveal_width=1366 --SlidesExporter.reveal_height=768

html:
	jupyter-nbconvert **/**.ipynb  --to html

zipall:
	zip -r bdcf-slides_with_data.zip . -x ".git/*" "bdcf-slides.zip"

zipcode:
	zip -r bdcf-slides.zip S* README.md requirements.txt setup.py setup_spark.sh -x "*/.ipynb_checkpoints/*"

sync:
	rsync -av --delete-excluded --prune-empty-dirs --include '*/' --include '*slides.zip' --include 'data/*' --include '*.ipynb' --include '*.slides.html' --include '*.slides.pdf' --include 'figures/*' --exclude '*' .  ${HOME}/nextcloud/feng.li/bdcf/
