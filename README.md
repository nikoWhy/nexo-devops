## NEXO DEVOPS ASSIGNMENT

> NOTE: Please notice I have included the .env file and the secrets in the repo. This is a bad practice, but as this is assigment that way will be easier to run everything.

The application is written in Python using the FastApi framework. I have taken the code from the offical documentation and just changed it to work with PostgreSQL.

You can run the whole application locally using `docker compose` as follow:
```sh
$ docker compose build
$ docker compose up -d
```
To verify that the app is running you can visit `http://127.0.0.1:8000/docs` where you can create records directly from the browser or use curl:
```sh
# Create a record
$ curl -X 'POST' \
  'http://127.0.0.1:8000/heroes/' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "name": "John",
  "age": 30,
  "secret_name": "Johny"  
}'

# Get all records
curl -X 'GET' \ 
  'http://127.0.0.1:8000/heroes/?offset=0&limit=100' \
  -H 'accept: application/json'
```

You can also deploy the application on minikube using either kubernetes yaml manifest files located in `k8s` folder or a helm chart in `helm` folder.

The helm chart contains a subchart with the Postgres deployed as a statefulset and using a volume claim for persistent.
You can run the helm as follow:
```sh
$ cd helm
$ helm install demo nexo-app
# Once the app POD is ready you can expose the service:
$ minikube service demo-nexo-service --url
```

Finally the Pipeline is pretty simple:
 - On Pull requests it builds the container image and it scans it for vulnerabilities with Trivy
 - When you merge to Main branch, builds and pushes pushes the image to DockerHub

This is the Container image repo: https://hub.docker.com/r/ilniko/nexo-devops