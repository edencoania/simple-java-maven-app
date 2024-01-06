# simple-java-maven-app

This project purpose is to build CI/CD pipeline using github actions.

The project build save and deploy docker image using multi-stage dockerfile in order to contarize java app.

The project use Github Secrets mechanisem.

the flow of the pipeline is 
- setting up enviroment and login to Dockerhub
- build and push to Dockerhub - 1 with commit hash , 1 as latest, 1 with changed VERSION
- deploy on aws - ec2, using flask app - that run the container every time entering to its URL.

In order to use this repo localy you will need:

1. set secrets.DOCKERHUB_USERNAME,secrets.DOCKERHUB_TOKEN 
2. change the place you push your version to - edencoania/release:hello_github_actions-${{ github.sha }}
3. change the app.py - docker image to take your container from.
4. set aws IAM credential in GITHUB secrets.
4. set up aws credentioals for terraform - it will build ec2, install docker engine 
4. change s3 bucket - or delete that file.
5. run terraform init and terraform apply
6.  


