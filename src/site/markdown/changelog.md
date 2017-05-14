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
Changelog
---------

#### 1.0.1

* Run the secured Spring MVC web application by generatin a Tomcat Bundle [#3](https://github.com/alexander-perucci/spring-grow/issues/3) 

## 1.0.0

* Provided automatic Integration Tests in order to test the code generated from the archetype [#1](https://github.com/alexander-perucci/spring-grow/issues/1)  
* Integration with Travis CI as hosted continuous integration and deployment system [#2](https://github.com/alexander-perucci/spring-grow/issues/2)  
* Run the secured Spring MVC web application using an embedded Tomcat instance without the need of installing a local Tomcat Server

The template of the secured Spring MVC web application manage an authenticated user from administrator to generic user point of view. Supported features are:

__Functional features for generic users:__
* Sig up, Sig in, Sig out on the web application
* Chage user settings (e.g., first name, last name, password, ...)
* Chage user avatar

__Functional features for administrator users (more than generic user):__
* Create, Update, Delete and Disable an user account
* Reset an user password
* Expire an user session