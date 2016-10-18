build:
	cd Docker && docker build -t mendixazure/mendix_azure  .

docker-push: build
	docker push mendixazure/mendix_azure

