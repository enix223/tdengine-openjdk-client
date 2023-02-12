.PHONY: run db

db:
	docker run -it --rm -d \
		--hostname=tdengine \
		-p 6030-6041:6030-6041 \
   		-p 6030-6041:6030-6041/udp \
		tdengine/tdengine:3.0.2.3

run:
	docker run -it --rm -v $(PWD)/target/tdengine-demo-3-1.0-SNAPSHOT-jar-with-dependencies.jar:/tdengine-demo-3.jar \
		-v $(PWD)/taos.cfg:/etc/taos/taos.cfg \
		--add-host=tdengine:172.17.0.2 \
		enix223/tdengine-openjdk-client:3.0.2.3 \
		java -jar /tdengine-demo-3.jar