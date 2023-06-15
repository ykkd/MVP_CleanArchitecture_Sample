.PHONY: help
help: ## Show this usage
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: setup-node
setup-node: ## setup node version management environment
	cat Scripts/zshrc_cp.txt >> ~/.zshrc
	exec ${SHELL} -l & \
	brew install nodenv
	nodenv install 18.1.0
	nodenv local 18.1.0

.PHONY: setup-precommit-tool
setup-precommit-tool: ## setup tools for linting at pre-commit
	npm install yarn -d
	npx yarn add husky lint-staged @commitlint/config-conventional @commitlint/cli -d
	npx yarn install
	npx yarn husky install
	sh Scripts/huskyrc.sh

.PHONY: remove-precommit-tool
remove-precommit-tool: ## remove tools for linting at pre-commit
	npx yarn remove husky lint-staged @commitlint/config-conventional @commitlint/cli -d
	npm uninstall yarn -d
	npm list -d
	npm list -g

.PHONY: open
open: ## Open xcworkspace
	open ./${PROJECT_NAME}

.PHONY: bootstrap
bootstrap: ## bootsrap
	make build-spm-cli-tools

.PHONY: build spm cli tools
build-spm-cli-tools: ## build Swift Package Manager cli tools
	swift build -c release --package-path ./Tools/Common --product mint

.PHONY: clean cli tools
clean-spm-cli-tools: ## clean Swift Package Manager cli tools cache
	swift package --package-path ./Tools/Common clean