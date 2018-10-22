# Usage

## Continuous Integration / Deployment
---

### Docker registry

When the option `allspark_docker_registry` is enabled, the stack will come with a
local Docker registry. This registry is only exposed on the host and the `allspark`
Docker network, in order to make it unavailable to an exernal user, but usable from
the continuous integration tools.

> Upload an image to the registry:

```sh
  # Suppose your image is named "myimage:latest"

  # Save the image on your local machine
  docker save -o img.tar.gz myimage:latest

  AS_USER="allspark"
  AS_HOST="allspark.localhost"

  # Upload the image to the Allspark host
  scp img.tar.gz $AS_USER@$AS_HOST:/tmp/img.tar.gz
  # Load the image in the Docker daemon
  ssh $AS_USER@$AS_HOST "docker load -i /tmp/img.tar.gz && rm /tmp/img.tar.gz"
  # Tag this image to push it to the local registry
  ssh $AS_USER@$AS_HOST "docker tag myimage:latest localhost:5000/myimage:latest"
  # Push the image
  ssh $AS_USER@$AS_HOST "docker push localhost:5000/myimage:latest"
```

You can later use the `localhost:5000/myimage:latest` from the host and continuous integration systems (i.e: Gitlab CI / Jenkins).
