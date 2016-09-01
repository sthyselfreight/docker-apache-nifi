![Apache NiFi logo](http://nifi.apache.org/images/niFi-logo-horizontal.png "Apache NiFi")
# docker-apache-nifi
## Version 1.0.0

### Apache NiFi Dockerfile

Provides a Dockerfile and associated scripts for configuring an instance of [Apache NiFi](http://nifi.apache.org) to run with certificate authentication.  

This version is directly derived from https://github.com/apiri/dockerfile-apache-nifi, the source container was changed to use openjdk:8 
installation paths changed to personal preferance.

## Sample Usage

From your checkout directory:
		
1. Build the image

        docker build -t sthysel/apache-nifi .
		
2. Run the image 

		docker run -it --rm \
	   	 	-p 8443:443 \
	    	-v ${cert_path}:/certs \
	    	-v $(readlink -f ./authorized-users.xml):/nifi/conf/authorized-users.xml \
	    	-e KEYSTORE_PATH=/certs/keystore.jks \
	    	-e KEYSTORE_TYPE=JKS \
	    	-e KEYSTORE_PASSWORD=password \
	    	-e TRUSTSTORE_PATH=/certs/truststore.jks \
	    	-e TRUSTSTORE_PASSWORD=password \
	    	-e TRUSTSTORE_TYPE=JKS \
	    	sthysel/apache-nifi

	`-v ${cert_path}:/certs` 
	maps the 'cert_path' location on the host system to the container as the source of the relevant keystores

	`-it` Allocates a TTY and keeps STDIN open

	`-v $(readlink -f ./authorized-users.xml):/nifi/conf/authorized-users.xml` Maps an authorized-users.xml into the container over the default one provided

3. Wait for the image to initalize
		
4. Access through your Docker host system
 	
		https://localhost:8443/nifi
		
5. Stopping
		
* From the terminal used to start the container above, perform a `Ctrl+C` to send the interrupt to the container.
* Alternatively, execute a docker command for the container via a `docker stop <container id>` or `docker kill <container id>`

		
## Conventions
### $NIFI_HOME
- The Dockerfile specifies an environment variable `NIFI_HOME` via the `ENV` command

### Volumes
- The following directories are exposed as volumes which may optionally be mounted to a specified location
	- `/certs`
	- `${NIFI_HOME}/flowfile_repository`
	- `${NIFI_HOME}/content_repository`
	- `${NIFI_HOME}/database_repository`
	- `${NIFI_HOME}/provenance_repository`
