.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

init: ## Initialize jsonnet project
	@jb init

fmt: ## Jsonnet format
	@find . -name '*.libsonnet' -print -o -name '*.jsonnet' -print | xargs -n 1 -- jsonnetfmt

gen: ## Generates json
	@mkdir -p target
	@jsonnet -J ./vendor main.jsonnet -o target/output.json