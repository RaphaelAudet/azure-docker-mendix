# azure-docker-mendix
<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FMendix%2Fazure-docker-mendix%2F66136e74f8c16f82e05102c4a120bc61f2026af5%2Fazure-docker-mendix.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

<a href="http://armviz.io/#/?load=https%3A%2F%2Fraw.githubusercontent.com%2FMendix%2Fazure-docker-mendix%2Fmaster%2Fazure-docker-mendix.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>


Start a Mendix application in a docker container in Azure by providing your MDA and configuration URL.

This allocates a new storage account and Azure SQL database for your application.

## Requirements:

* Microsoft Azure Account (you need privileges to run ARM templates and a valid subscription)

*  *Optional*: If you wish to customize your Mendix application configuration (for application constants...) you should use the template *m2ee.azure.yaml* file and provide the location of your configuration


## Local testing

You may run your application locally for testing. You must make sure your configuration *YAML* defines correct storage and database values.

```
cd test
docker-compose up
```

# Under development

This project is still under development.
