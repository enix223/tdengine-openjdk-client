.PHONY: cli-17-3

cli-17-3:
	docker build -t enix223/tdengine-client-jdk-17:3.0.2.3 \
		--build-arg JDKVER=17 \
		--build-arg VERSION=3.0.2.3 \
		.
