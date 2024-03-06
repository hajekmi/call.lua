SHELL := /bin/bash
ROCKSPECFILE := call.lua.rockspec

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
	@grep -P '^\s*version\s*=\s*"' src/call.lua | sed 's~.*"\([^"]*\)".*~\1~'

createversion:
	@$(eval MY_VERSION=$(shell make getversion))

	echo "$(MY_VERSION)"
	sed -i 's~^version = "\([0-9a-z.-]*\)".*~version = "$(MY_VERSION)-1"~' ${ROCKSPECFILE}
	sed -i 's~^\(\s*tag\) = "\([0-9a-z.-]*\)".*~\1 = "$(MY_VERSION)"~' ${ROCKSPECFILE}
	git add ${ROCKSPECFILE}
	git commit -m "Update rockspec file"
	git push origin

	git tag -a $(MY_VERSION) -m "Version $(MY_VERSION)"
	git push origin --tags

uploadrock:
	@# run export LUAROCK_API_KEY=.......
	@$(eval MY_VERSION=$(shell make getversion))
	@#luarocks upload call-2024.3.4.2-1.rockspec --api-key=$(LUAROCK_API_KEY)
	@echo "LUAROCK_API_KEY=$(LUAROCK_API_KEY)"

	rm -f call-*-1.rockspec
	ln -s ${ROCKSPECFILE} call-${MY_VERSION}-1.rockspec

	luarocks upload call-${MY_VERSION}-1.rockspec --api-key=$(LUAROCK_API_KEY)
	rm -f call-${MY_VERSION}-1.src.rock

clean:
	@$(eval MY_VERSION=$(shell make getversion))
	rm -f call-${MY_VERSION}-1.src.rock
	rm -f call-*-1.rockspec

# vim: noexpandtab filetype=make
