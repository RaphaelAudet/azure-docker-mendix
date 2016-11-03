build-azure:
	cd Docker && docker build -t mendix/mendix_azure:custom_m2ee  .

push-azure: build-azure
	docker push mendix/mendix_azure:custom_m2ee

build-nginx:
	cd Docker-Nginx && docker build -t mendix/nginx_azure  .

push-nginx: build-nginx
	docker push mendix/nginx_azure
