
.DEFAULT_GOAL := help

.PHONY:

export SHELL=/bin/bash
export TZ=:UTC

directories:
	mkdir -p ./config

up: directories down ## Bring up gethomepage
	docker compose up -d && \
	echo "open http://localhost:3000"

down: ## Bring down gethomepage
	docker compose down

clean: down ## docker system prune -a (DANGEROUS)
	docker system prune -a

print-%:
	@echo $*=$($*)

export MAKEFILE_LIST=Makefile

help:
	@printf "\033[37m%-30s\033[0m %s\n" "#----------------------------------------------------------------------------------"
	@printf "\033[37m%-30s\033[0m %s\n" "# Makefile targets                                                                 |"
	@printf "\033[37m%-30s\033[0m %s\n" "#----------------------------------------------------------------------------------"
	@printf "\033[37m%-30s\033[0m %s\n" "#-target-----------------------description-----------------------------------------"
	@grep -E '^[a-zA-Z_-].+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
