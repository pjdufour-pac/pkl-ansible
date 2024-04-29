# ==================================================================================
#
# Work of the U.S. Department of the Navy, Naval Information Warfare Center Pacific.
# Released as open source under the MIT License.  See LICENSE file.
#
# ==================================================================================

.PHONY: help
help:  ## Print the help documentation
	@grep -E '^[/a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

clean:  ## Remove automatically generated files
	find . -name .out | xargs -I {} rm -fr {}

.PHONY: resolve
resolve: ## Resolve dependencies for project(s) if they do not exist
	pkl project resolve packages/*/ --ca-certificates pem/github.com.pem

.PHONY: package
package: ## Verify package(s), and prepare package artifacts to be published.
	pkl project package packages/*/ --ca-certificates pem/github.com.pem

.PHONY: test
test: ## Verify package(s), and prepare package artifacts to be published.
	scripts/pkl-test
