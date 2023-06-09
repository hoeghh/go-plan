build-plan:
#	@echo "Hello Bura : $(BURAFILE)"
#	@echo "Hello Plan : $(PLAN)"
	@# Help: A target to build the local service repo
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

scan-plan:
	@# Help: A target to security scan the local service repo
ifneq ("$(wildcard ./scripts/scan.sh)","")
	@./scripts/scan.sh
else
	@./.plan/scripts/scan.sh
endif

copy-scan-plan:
	@# Help: A helper target to copy the remote security scan script to local service repo
	@mkdir -p scripts
	@ORG_REPO=$(shell echo $(PLAN) | cut -d"/" -f4- | cut -d"." -f1); \
		curl --location --silent https://raw.githubusercontent.com/$$ORG_REPO/main/scripts/scan.sh > ./scripts/scan.sh && \
		chmod u+x ./scripts/scan.sh
