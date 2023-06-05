build-plan:
	@# Help: A remote target to build project
ifneq ("$(wildcard ./scripts/build.sh)","")
# Local ./script/build.sh file exit, use that.
	@./scripts/build.sh
else
# Use the one supplied file by the plan.
	@./.plan/scripts/build.sh
endif
