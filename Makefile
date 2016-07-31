default: home root

home: FORCE
	stow -S home -t ~

root: FORCE

clean-home: FORCE
	stow -D home -t ~

clean-root: FORCE

clean: clean-home clean-root

FORCE:
