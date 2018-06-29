# fake-s3

Dockerfile for
[mrister/fake-s3](https://registry.hub.docker.com/u/mrister/fake-s3/)
on [Docker Hub](https://registry.hub.docker.com).

Deploys [fake-s3](https://github.com/jubos/fake-s3) in a Docker container from master branch with option to allow CORS headers control

To create a deployment:

        docker run --name local_s3 -d mrister/fake-s3

Service exposed on port 4569.  Credentials are ignored all CORS headers set to value `*`
See [fake-s3](https://github.com/jubos/fake-s3) README for details/limitations.

If you want fake-s3 to be exposed on your Docker host on port 4569, then

        docker run --name local_s3 -p 4569:4569 -d mrister/fake-s3

If you want the container to use a volume, then

        docker run --name local_s3 -v /fakes3_root -d mrister/fake-s3

The fake-s3 root directory will then be added as a volume on the Docker host. To get the volume

        docker inspect --format "{{range .Mounts}}{{.Source}}{{end}}" local_s3

If you want the container to use a CORS environment variables, then

        docker run --name local_s3 -v /fakes3_root -p 4569:4569 \
                            -e "CORS_PREFLIGHT_ALLOW_HEADERS=*" \
                            -e "CORS_ORIGIN=*" \
                            -e "CORS_METHODS=*" \
                            -e "CORS_POST_PUT_ALLOW_HEADERS=*" \
                            -e "CORS_EXPOSE_HEADERS=*" \
                            -d mrister/fake-s3

### Inpiration
I needed a version that was nt throwing errors due to CORS on latest aws-sdk-js for demoing purposes so I decide to build this docker image based on https://github.com/lphoward/fake-s3
