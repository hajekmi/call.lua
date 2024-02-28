SHELL := /bin/bash

help:
	@echo "=== Targets ==="
	@grep '^[^#[:space:]].*:' Makefile

test: test1

test1:
	cd test && lua test.lua

install:
	@echo "Copy file src/call.lua to your own project"

getversion:
	@grep '\s*version\s*=\s*"' src/call.lua | sed 's~.*"\([^"]*\)".*~\1~'

createversion:
	@$(eval MY_VERSION=$(shell make getversion))

	echo "$(MY_VERSION)"
	git tag -a $(MY_VERSION) -m "Version $(MY_VERSION)"
	git push origin --tags

# vim: noexpandtab filetype=make
