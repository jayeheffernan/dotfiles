default: home root

home: FORCE
	stow -S home -t ~

root: FORCE

clean: FORCE
	stow -D home -t ~

FORCE:
