# copy-build-container-plan:
# 	@# Help: A helper target to copy the remote build container script to local service repo
# 	@mkdir -p scripts
# 	@ORG_REPO=$(shell echo $(PLAN) | cut -d"/" -f4- | cut -d"." -f1); \
# 		curl --location --silent https://raw.githubusercontent.com/$$ORG_REPO/main/scripts/build-container.sh > ./scripts/build-container.sh && \
# 		chmod u+x ./scripts/build-container.sh

copy-%: 
	@# Help: A helper target to copy the remote script to local service repo
	@echo "Copying script"
	@mkdir -p scripts
	@ORG_REPO=$(shell echo $(PLAN) | cut -d"/" -f4- | cut -d"." -f1); \
		TARGET=$(shell echo $(@) | cut -d"-" -f 2); \
 		curl --location --silent https://raw.githubusercontent.com/$$ORG_REPO/main/scripts/$$TARGET.sh > ./scripts/$$TARGET.sh && \
 		chmod u+x ./scripts/$$TARGET.sh

%: 
	@# Help: A target to build the local service container
ifneq ("$(wildcard ./scripts/$@.sh)","")
	@./scripts/$@.sh
else
	@./.plan/scripts/$@.sh
endif

# build-container-plan:
# 	@# Help: A target to build the local service container
# ifneq ("$(wildcard ./scripts/build-container.sh)","")
# 	@./scripts/build-container.sh
# else
# 	@./.plan/scripts/build-container.sh
# endif

# copy-build-container-plan:
# 	@# Help: A helper target to copy the remote build container script to local service repo
# 	@mkdir -p scripts
# 	@ORG_REPO=$(shell echo $(PLAN) | cut -d"/" -f4- | cut -d"." -f1); \
# 		curl --location --silent https://raw.githubusercontent.com/$$ORG_REPO/main/scripts/build-container.sh > ./scripts/build-container.sh && \
# 		chmod u+x ./scripts/build-container.sh

# build-plan:
# 	@# Help: A target to build the local service repo
# ifneq ("$(wildcard ./scripts/build.sh)","")
# 	@./scripts/build.sh
# else
# 	@./.plan/scripts/build.sh
# endif

# copy-build-plan:
# 	@# Help: A helper target to copy the remote build script to local service repo
# 	@mkdir -p scripts
# 	@ORG_REPO=$(shell echo $(PLAN) | cut -d"/" -f4- | cut -d"." -f1); \
# 		curl --location --silent https://raw.githubusercontent.com/$$ORG_REPO/main/scripts/build.sh > ./scripts/build.sh && \
# 		chmod u+x ./scripts/build.sh

# scan-plan:
# 	@# Help: A target to security scan the local service repo
# ifneq ("$(wildcard ./scripts/scan.sh)","")
# 	@./scripts/scan.sh
# else
# 	@./.plan/scripts/scan.sh
# endif

# copy-scan-plan:
# 	@# Help: A helper target to copy the remote security scan script to local service repo
# 	@mkdir -p scripts
# 	@ORG_REPO=$(shell echo $(PLAN) | cut -d"/" -f4- | cut -d"." -f1); \
# 		curl --location --silent https://raw.githubusercontent.com/$$ORG_REPO/main/scripts/scan.sh > ./scripts/scan.sh && \
# 		chmod u+x ./scripts/scan.sh
