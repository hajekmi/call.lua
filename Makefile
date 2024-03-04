SHELL := /bin/bash

.DEFAULT_GOAL = help

help:
	@echo "=== Targets ==="
	@grep '^[^#[:space:]]*:' Makefile

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

uploadrock:
	@# run export LUAROCK_API_KEY=.......
	luarocks upload call-2024.3.4.2-1.rockspec --api-key=$(LUAROCK_API_KEY)

# vim: noexpandtab filetype=make
