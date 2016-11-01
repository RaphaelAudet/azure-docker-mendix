build-azure:
	cd Docker && docker build -t mendix/mendix_azure  .

push-azure: build-azure
	docker push mendix/mendix_azure

build-nginx:
	cd Docker-Nginx && docker build -t mendix/nginx_azure  .

push-nginx: build-nginx
	docker push mendix/nginx_azure
