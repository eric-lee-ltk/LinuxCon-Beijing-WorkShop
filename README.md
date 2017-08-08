# ServiceComb Demo - Company [![Build Status](https://travis-ci.org/ServiceComb/LinuxCon-Beijing-WorkShop.svg?branch=master)](https://travis-ci.org/ServiceComb/LinuxCon-Beijing-WorkShop)[![Coverage Status](https://coveralls.io/repos/github/ServiceComb/LinuxCon-Beijing-WorkShop/badge.svg)](https://coveralls.io/github/ServiceComb/LinuxCon-Beijing-WorkShop)

## Purpose
In order for users to better understand how to develop microservices using ServiceComb, an easy to
understand demo is provided.

## Architecture of Company
* Manager (API gateway) 
* Doorman (authentication service)
* Worker (computing service)
* Beekeeper (computing service)
* Bulletin board (service registry)
* Project archive (request cache)
* Human resource (service governance)

Please read the [blog post](http://servicecomb.io/docs/linuxcon-workshop-demo/) on the detailed explanation of this project.

## Prerequisites
You will need:
1. [Oracle JDK 1.8+][jdk]
2. [Maven 3.x][maven]
3. [Docker][docker]
4. [Docker compose(optional)][docker_compose]
5. [Docker machine(optional)][docker_machine]
6. [curl][curl]

[docker]: https://www.docker.com/get-docker
[docker_compose]: https://docs.docker.com/compose/install/
[docker_machine]: https://docs.docker.com/machine/install-machine/
[curl]: https://curl.haxx.se

## Run Services
A `docker-compose.yaml` file is provided to start all services and their dependencies as docker containers.
1. Build all service images using command `mvn package -Pdocker`
1. Run all service images using command `docker-compose up`

If you are using [Docker Toolbox](https://www.docker.com/products/docker-toolbox), please add an extra profile `-Pdocker-machine`.

```mvn package -Pdocker -Pdocker-machine```

## Run Integration Tests

```
mvn verify -Pdocker -Pdocker-machine
```

## Verify services
You can verify the services using curl by the following steps:
1. Retrieve manager's ip address
  * If you use docker compose:
    ```bash
    export IP="127.0.0.1"
    ```
  * If you use docker machine(supposed your docker machine name is `default`):
    ```bash
    export IP=$(docker-machine ip default)
    ```
2. Log in and retrieve token from `Authorization` section
  ```bash
  curl -v -H "Content-Type: application/x-www-form-urlencoded" -d "username=jordan&password=password" -XPOST "http://$IP:8083/doorman/rest/login"
  ```
  Then you can copy the token from the `Authorization` section and use it to replace the `Authorization` header in the following requests.
3. Get the sixth fibonacci number from the worker service
  ```bash
  curl -H "Authorization: replace_with_the_authorization_token" -XGET "http://$IP:8083/worker/fibonacci/term?n=6"
  ```
4. Get the number of drone's ancestors at the 30th generation from the beekeeper service
  ```bash
  curl -H "Authorization: replace_with_the_authorization_token" -XGET "http://$IP:8083/beekeeper/rest/drone/ancestors/30"
  ```
5. Get the number of queen's ancestors at the 30th generation from the beekeeper service
  ```bash
  curl -H "Authorization: replace_with_the_authorization_token" -XGET "http://$IP:8083/beekeeper/rest/queen/ancestors/30"
  ```

## Auto CI/CD(based on [Huawei Cloud][huawei_cloud])
To auto compile, build, deploy and run this workshop demo on Huawei Cloud's [Service Stage Platform][service_stage], you need the following steps:

### Prerequisites
1. Linux
2. [Docker 1.11.2][docker_install_guide]
3. [Maven 3.x][maven]
4. [Oracle JDK 1.8+][jdk]
5. A registered [Service Stage][service_stage] account

### Auto build
1. Get the workshop demo code
  ```bash
  git clone https://github.com/ServiceComb/LinuxCon-Beijing-WorkShop.git
  ```
2. Set up environment variables of `scripts/publish_images_to_huaweicloud.sh` according to [script usage guide][script_guide].
3. run the script by executing
  ```bash
  bash scripts/publish_images_to_huaweicloud.sh
  ```
  Wait for a while and then you can check your image in the service stage repository.

### Auto deploy
You can use the existing workshop demo images or build it your own following the auto build steps. Then you can deploy this demo and access it.
* Import auto deploy template. Browser [Service Stage template website][template_website],
click the *Create Template* button and upload the predefine template `scripts/workshop-blueprint-deploy-template-v1.tar.gz`.
**Be Cautious**: You might need to change some settings in the template, e.g. cluster name, image location.
* Auto deploy. Click the *Deploy* button in your template's section.
* Verify services' status. Browser [Services][services_website], and click the `manager` service.
Then you can see the *Address* column, it's the ip address you can access from the outside.
Now you can replace the `IP` variable with the address in the previous **Verify Services** section and try it.


[jdk]: http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
[maven]: https://maven.apache.org/install.html
[huawei_cloud]: http://www.hwclouds.com
[service_stage]: https://servicestage.hwclouds.com/servicestage
[docker_install_guide]: docs/how-to-install-docker.md
[script_guide]: docs/how-to-set-up-image-upload-script.md
[template_website]: https://servicestage.hwclouds.com/servicestage/#/stage/template/list
[services_website]: https://servicestage.hwclouds.com/servicestage/#/stage/app/list