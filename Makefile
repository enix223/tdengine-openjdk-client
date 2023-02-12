.PHONY: cli-17-3

cli-17-3:
	docker build \
		--build-arg JDKVER=17.0.6_10 \
		--build-arg TDVERSION=3.0.2.5 \
		--tag enix223/tdengine-openjdk-client:17.0.6_10-3.0.2.5 \
		--tag enix223/tdengine-openjdk-client:17-3.0.2.5 \
		.
