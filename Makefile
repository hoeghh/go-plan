copy-%:
	@echo "Copying script"
	@mkdir -p scripts
	@ORG_REPO=$(shell echo $(PLAN) | cut -d"/" -f4- | cut -d"." -f1); \
		TARGET=$(shell echo $(@) | cut -d"-" -f 2); \
 		curl --location --silent https://raw.githubusercontent.com/$$ORG_REPO/main/scripts/$$TARGET.sh > ./scripts/$$TARGET.sh && \
 		chmod u+x ./scripts/$$TARGET.sh

%: 
ifneq ("$(wildcard ./scripts/$@.sh)","")
	@echo "running ./scripts/$@.sh"
	@./scripts/$@.sh
else
	@echo "running ./.plan/scripts/$@.sh"
	@./.plan/scripts/$@.sh
endif