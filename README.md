# simple-java-maven-app

This project purpose is to build CI/CD pipeline using github actions.

The project build save and deploy docker image using multi-stage dockerfile in order to contarize java app.

In order to overcome the problem of container up momentrory, I build minimum flask app that run print the output and remove the container every time the url is entered.

The project uses Github Secrets mechanisem.

2 parallel pipelines: 
1. Change version in pom.xml file and push it back to the github repo.
-
2. Main pipeline:
- Setting up enviroment and login to Dockerhub
- Build and push to Dockerhub - 1 with commit hash , 1 as latest.
- Delete current image on aws - ec2, making pull request to the latest container 

---- inside the ec2 - infinitly - run flask app that run the current container in the machine.


- In the next version - terraform deoplyment all infrastructure - stay tuned.


In order to use this repo localy you will need:

1. Set secrets.DOCKERHUB_USERNAME,secrets.DOCKERHUB_TOKEN 
2. Change the place you push your version to - edencoania/release:hello_github_actions-${{ github.sha }}
3. Change the app.py - docker image to take your container from.
 
4. Set up secrets.DOCKERHUB_USERNAME, secrets.DOCKERHUB_TOKEN.
5. Set up secrets.SSH_PRIVATE_KEY - to your machine (the machine needs the app.py , docker running and python and flsk installed)
6. Change host IP address.

7. Change git user.name, git user.email in version
