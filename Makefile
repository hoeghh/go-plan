build-plan:
	@# Help: A remote target to build project
ifneq ("$(wildcard ./scripts/build.sh)","")
# Local ./script/build.sh file exit, use that.
	@./scripts/build.sh
else
# Use the one supplied file by the plan.
	@./.plan/scripts/build.sh
endif


copy-build-plan:
	@# Help: A helper target to copy the remote build script to local service repo
	@echo $(RAW_URL)
	@mkdir -p scripts
	@curl --location --silent https://raw.githubusercontent.com/$(RAW_URL)/main/scripts/build.sh > ./scripts/build.sh
	@chmod u+x ./scripts/build.sh
