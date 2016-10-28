build-azure:
	cd Docker && docker build -t mendixazure/mendix_azure  .

push-azure: build-azure
	docker push mendixazure/mendix_azure

build-nginx:
	cd Docker-Nginx && docker build -t mendixazure/nginx_azure  .

push-nginx: build-nginx
	docker push mendixazure/nginx_azure
