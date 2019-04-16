TARGETS := $(shell ls scripts | grep -vE 'clean|help')

.dapper:
	@echo Downloading dapper
	@curl -sL https://releases.rancher.com/dapper/latest/dapper-`uname -s`-`uname -m|sed 's/v7l//'` > .dapper.tmp
	@@chmod +x .dapper.tmp
	@./.dapper.tmp -v
	@mv .dapper.tmp .dapper

$(TARGETS): .dapper
	./.dapper $@ 2>&1 | tee $@.log

shell-bind: .dapper
	./.dapper -m bind -s

help:
	@./scripts/help

.DEFAULT_GOAL := ci

.PHONY: $(TARGETS) config
