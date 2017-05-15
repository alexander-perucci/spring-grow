<!--
Copyright 2017 Alexander Perucci

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->
## Introduction

Spring Grow is a Maven Archetype that creates a maven project for building a secured web application using Spring Web MVC Framework and Spring XML based configuration. If you need to quickly start up a template of a Spring MVC web application that is secured with Spring Security then this archetype is a good starting point.

__Technological features:__

* Spring Web MVC

* Spring XML based configuration

* Spring Object Relational Mapping (ORM) Data Access

* Spring Security

* Hibernate JPA

* JavaServer Pages (JSP)

* JSP Standard Tag Library (JSTL)

* Apache Tiles

* Apache Maven

## How do I create a new Spring MVC web application using 'grow'?

Spring-grow is available in maven central repository so you don't need to build the project locally. In order to create your Spring MVC web application, you need to run the `mvn archetype:generate` as follow:

`mvn archetype:generate -DgroupId=YOUR_WEB_APPLICATION_GROUP_ID -DartifactId=YOUR_WEB_APPLICATION_ARTIFACT_ID -Dversion=YOUR_WEB_APPLICATION_VERSION -DwebApplicationName=YOUR_WEB_APPLICATION_NAME -Dpackage=YOUR_WEB_APPLICATION_ROOT_JAVA_PACKAGE -DarchetypeGroupId=com.alexanderperucci -DarchetypeArtifactId=spring-grow -DarchetypeVersion=1.0.1 -DinteractiveMode=false`

Example:

`mvn archetype:generate -DgroupId=com.library -DartifactId=movies -Dversion=1.0.0-SNAPSHOT -DwebApplicationName='Library of Movies' -Dpackage=com.library.movies -DarchetypeGroupId=com.alexanderperucci -DarchetypeArtifactId=spring-grow -DarchetypeVersion=1.0.1 -DinteractiveMode=false`

This will create a template of the secured web application locally named [YOUR_WEB_APPLICATION_ARTIFACT_ID].

## Can I try the created Spring MVC web application without change anything?

Yes, but at the currently version of the archetype, the created Spring MVC web application require an instance of MySQL in running on your machine.
Anyway, once you have create the web application, you should create the database schema and import sample data to it. You can find both `[YOUR_WEB_APPLICATION_ARTIFACT_ID]-schema.sql` and `[YOUR_WEB_APPLICATION_ARTIFACT_ID]-data.sql` SQL scripts in the root directory of the secured web application which they will do it for you.

When the MySQL database will be ready, you just have to decide how to run the web application i.e., in `embedded` mode or `building a Tomcat bundle`.

#### Running in embedded mode

You can run an embedded Tomcat instance without the need of installing a local Tomcat Server, you just have to run `mvn -Pembedded` in the root directory of the secured web application
and maven will start the embedded Tomcat instance on port `8090`. Check at http://localhost:8090/[YOUR_WEB_APPLICATION_ARTIFACT_ID] and put username: admin and password: password to sig in.

#### Building a Tomcat bundle

Building a Tomcat bundle is also very simple, you just have to run `mvn -Pbuild-tomcat` in the root directory of the secured web application. Unlike before you can find the Tomcat bundle on `target/[YOUR_WEB_APPLICATION_ARTIFACT_ID]-[YOUR_WEB_APPLICATION_VERSION].zip`. You just have to do unzip the bundle and execute the script (i.e., startup.sh or startup.bat) in order to start Tomcat on port `8090`. Check at http://localhost:8090/[YOUR_WEB_APPLICATION_ARTIFACT_ID] and put username: admin and password: password to sig in.

## What features are already implemented?

For now, the template of the secured Spring MVC web application manage an authenticated user from administrator to generic user point of view.

__Functional features for generic users:__

* Sig up, Sig in, Sig out on the web application

* Chage user settings (e.g., first name, last name, password, ...)

* Chage user avatar


__Functional features for administrator users (more than generic user):__

* Create, Update, Delete and Disable an user account

* Reset an user password

* Expire an user session

## Where is my contribution?

1. Define your database schema chainging `[YOUR_WEB_APPLICATION_ARTIFACT_ID]-schema.sql` and `[YOUR_WEB_APPLICATION_ARTIFACT_ID]-data.sql` (note that: changes in User and Role tables involves changes in the provided features)
2. Define your business model in `[YOUR_WEB_APPLICATION_ROOT_JAVA_PACKAGE].business.model` and register each business class in `src/main/resources/META-INF/persistence.xml`
3. Define a service for each business model class in `[YOUR_WEB_APPLICATION_ROOT_JAVA_PACKAGE].business` and provide a JPA implementation `[YOUR_WEB_APPLICATION_ROOT_JAVA_PACKAGE].business.impl` for each service. (Don't worry for the service and the related JPA implementation, is very simple, see `RoleService.java` and `JPARoleService.java` to get an idea)
4. Create a controller in `[YOUR_WEB_APPLICATION_ROOT_JAVA_PACKAGE].presentation`, provide a view mapping in `src/main/webapp/WEB-INF/spring/tiles-defs.xml` and define the jsp view in `src/main/webapp/WEB-INF/views/`

## Contribute
You can also support this project by donating on Gratipay [here](https://www.gratipay.com/alexander_perucci/)

## License
Licensed under the Apache Software License, Version 2.0.