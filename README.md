# azure-docker-mendix
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMendix%2Fazure-docker-mendix%2Fmaster%2Fazure-docker-mendix.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>


<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FMendix%2Fazure-docker-mendix%2Fmaster%2Fazure-docker-mendix.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>


Start a Mendix application in a docker container in Azure by providing your MDA and configuration URL.

This allocates a new storage account and Azure SQL database for your application.

## Requirements:

* Microsoft Azure Account (you need privileges to run ARM templates and a valid subscription)
* Mendix 6.9 application package MDA available throught a wget download


*  *Optional*: If you wish to customize your Mendix application configuration (for application constants...) you should use the template *m2ee.azure.yaml* file and provide the location of your configuration


## Local testing

You may run your application locally for testing. You must make sure your configuration *YAML* defines correct storage and database values.

Example:

```
docker run -i --name mendix_azure -e "PACKAGE_URL=http://myserver.com/application.mda" -e  "CONFIG_URL=http://myserver.com/application.yaml" -P mendixazure/mendix_azure
```

# Under development

This project is still under development.
