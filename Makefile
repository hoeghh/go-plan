build-plan:
#	@echo "Hello Bura : $(BURAFILE)"
#	@echo "Hello Plan : $(PLAN)"
ifneq ("$(wildcard ./scripts/build.sh)","")
	@./scripts/build.sh
else
	@./.plan/scripts/build.sh
endif

copy-build-plan:
	@# Help: A helper target to copy the remote build script to local service repo
	@mkdir -p scripts
	@ORG_REPO=$(shell echo $(PLAN) | cut -d"/" -f4- | cut -d"." -f1); \
		curl --location --silent https://raw.githubusercontent.com/$$ORG_REPO/main/scripts/build.sh > ./scripts/build.sh && \
		chmod u+x ./scripts/build.sh
