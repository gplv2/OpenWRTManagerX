.PHONY: all run_dev_web run_dev_mobile run_unit clean upgrade lint format build_dev_mobile help doc

all: lint format run_dev_mobile

help: ## show help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

run_unit: ## Runs unit tests
	@echo "╠ Running the tests"
	@flutter test || (echo "Error while running tests"; exit 1)

clean: doc_clean ## Cleans the environment
	@echo "╠ Cleaning the project..."
	@rm -rf pubspec.lock
	@flutter clean

format: ## Formats the code
	@echo "╠ Formatting the code"
	@dart format .

doc: ## build docs on the lib code
	@echo "╠ Documenting the code"
	flutter pub global run dartdoc lib/

doc_clean: ## Cleanup of the documentation code
	@echo "╠ Clean doc code"
	@rm -Rf doc/api/*

lint: ## Lints the code
	@echo "╠ Verifying code..."
	@dart analyze . || (echo "Error in project"; exit 1)

upgrade: clean ## Upgrades dependencies
	@echo "╠ Upgrading dependencies..."
	@flutter pub upgrade

commit: format lint run_unit
	@echo "╠ Committing..."
	git add .
	git commit

run_dev_web: ## Runs the web application in dev
	@echo "╠ Running the app"
	@flutter run -d chrome --dart-define=ENVIRONMENT=dev

run_dev_mobile: ## Runs the mobile application in dev
	@echo "╠ Running the app"
	@flutter run --flavor dev

build_dev_mobile: clean run_unit
	@echo "╠  Building the app"
	@flutter build apk --flavor dev

run_emulator: build_dev_mobile  ## start the flutter emulator
	@echo "╠  Starting emulator"
	@flutter emulators --launch Pixel_XL_API_32

