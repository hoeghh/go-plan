.PHONY: no_targets__ list
no_targets__:
list:
	@echo ""
	@printf "%-5s %-20s %s\n" "Location" "Target" "Description"
	@printf "%-8s %-20s %s\n" "--------" "--------------------" "---------------------------------------------------"
	@if [ -d ./scripts/ ]; then \
		grep -rnw ./scripts/ -e 'Help' --include='*' \
			| awk -F ':' '{split($$1, parts, "/"); split(parts[length(parts)], filename, "."); printf "%-8s %-20s %s\n", "local", filename[1], substr($$0, index($$0, ":")+10)}'; \
	fi
	@grep -rnw .plan/scripts/ -e 'Help' --include='*' \
		| awk -F ':' '{split($$1, parts, "/"); split(parts[length(parts)], filename, "."); printf "%-8s %-20s %s\n", "plan", filename[1], substr($$0, index($$0, ":")+10)}'
	@echo ""
	
copy-%:
	@echo "Copying script"
	@mkdir -p scripts
	@ORG_REPO=$(shell echo $(PLAN) | cut -d"/" -f4- | cut -d"." -f1); \
		TARGET=$(shell echo $(@) | cut -d"-" -f 2); \
 		curl --location --silent https://raw.githubusercontent.com/$$ORG_REPO/main/scripts/$$TARGET.sh > ./scripts/$$TARGET.sh && \
 		chmod u+x ./scripts/$$TARGET.sh

%:
	@if [ -f ./scripts/$@.sh ]; then \
		./scripts/$@.sh; \
	elif [ -f .plan/scripts/$@.sh ]; then \
		.plan/scripts/$@.sh; \
	else \
		echo "No script found...."; \
	fi
# Cant get this to work...
# ifneq ($(wildcard scripts/$(@).sh),)
# 		@./scripts/$@.sh
# else
# 		@.plan/scripts/$@.sh
# endif