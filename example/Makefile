.PHONY: run db

init:
	docker run -it --rm -d \
		--name tdengine-openjdk-demo \
		--hostname=tdengine \
		-p 6030-6041:6030-6041 \
   		-p 6030-6041:6030-6041/udp \
		tdengine/tdengine:3.3.0.3

prepare: init
	sleep 5 && docker exec -it tdengine-openjdk-demo taos -s "create database db"

package:
	./mvnw package

run: package
	IP=$$(docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' tdengine-openjdk-demo) && \
	docker run -it --rm -v $(PWD)/target/tdengine-demo-1.0-SNAPSHOT-jar-with-dependencies.jar:/tdengine-demo.jar \
		-v $(PWD)/taos.cfg:/etc/taos/taos.cfg \
		--add-host=tdengine:$$IP \
		enix223/tdengine-openjdk-client:17.0.11_9-jdk-focal-3.3.0.3 \
		java -jar /tdengine-demo.jar

clean:
	docker stop tdengine-openjdk-demo