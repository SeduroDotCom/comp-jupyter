# comp-jupyter
> Jupyter boilerplate / redis / graphQL


## Setup Python / venv / requirements
Install
```
 brew install pyenv
```

### Getting started workflow

Use virtualEnv to work within project-scoped python version that is also used to backup installed pip-libs.
CAUTION: Always work with virEnv 

1. Check current python-version by `python -V`
1. Create virtual-env
   ```
   python3 -m venv .venv
   source .venv/bin/activate
   
   OR with one liner
   
   python3 -m venv .venv && source .venv/bin/activate
   ```
1. PyCharm: Include and set .venv by  ***IDE: right-bellow-corner > AddInterpreter > Existing Environment***
1. Build new image
```
docker build -t my-jupyter .
```
1. Run new container
```
docker run -p 8888:8888 \
    -v $(pwd)/notebooks:/project/notebooks \
    -v $(pwd)/data:/project/data \
    --name my-jupyter \
    --rm \
    my-jupyter
```

### Example how add & persist new lib (backup)
1. Add needed python-libs by e.g. `pip install flask`
1. Backup current setting by `pip freeze > requirements/requirements.txt`
1. Restore setup by `python -m pip install -r requirements.txt`
1. Build new image
```
docker build -t my-jupyter .
```
1. Run new container
```
docker run -p 8888:8888 \
    -v $(pwd)/notebooks:/project/notebooks \
    -v $(pwd)/data:/project/data \
    --name my-jupyter \
    --rm \
    my-jupyter
```

### Additinal commands
```
# List all currently installed libs 
pip list
```

### Docker-localhost for mac
> Keep in mind that for mac your need `docker.for.mac.localhost`
```
rd = redis.Redis(host='docker.for.mac.localhost', port=6379, db=0, decode_responses=True)
```

---

## Additional
### Docker / Jupyter
1. Tutorial
   - https://u.group/thinking/how-to-put-jupyter-notebooks-in-a-dockerfile/
2. Assign password/token for run/docker-compose
   - https://stackoverflow.com/questions/48875436/jupyter-password-and-docker

   ```
   # for docker run
   -e PASSWORD=password

   # for docker-compose
   environment:
       - PASSWORD=password

   environment:
       - JUPYTER_TOKEN=easy
   ```
   
   
 ### Access to mongoDB
 1. Setup jupyter with mongoDB
   - https://medium.com/@pragya_paudyal/connecting-mongodb-to-jupyter-notebook-e3f636a85830
 2. Full mongoDB-tutorial
   - https://www.youtube.com/watch?v=ofme2o29ngU

---

## Docker

### Redis commands [python-redis-command](https://koalatea.io/python-redis-hash/)

### Build & run image
#### Run jupyter
```
# build image
docker build -t my-jupyter .
    
# run container
docker run -p 8888:8888 \
    -v $(pwd)/notebooks:/project/notebooks \
    -v $(pwd)/data:/project/data \
    --name my-jupyter \
    --rm \
    my-jupyter
                                       
# run container with datapool-volume
docker run -p 8888:8888 \
    -v $(pwd)/notebooks:/project/notebooks \
    -v $(pwd)/data:/project/data \
    -v /Users/competec/datapool/datapool:/project/datapool \
    --name my-jupyter \
    --rm \
    my-jupyter
```

#### Import by redis-file
```
# run redis container
docker run -d -p 6379:6379 --name redis redis;

redis-cli -h localhost -p 6379 < test-data-users.redis
redis-cli -h localhost -p 6379 < ./notebooks/test-data-users.redis
```

#### Nginx-Image

[Docker: Nginx-Tutorial](https://www.docker.com/blog/how-to-use-the-official-nginx-docker-image/)
Use: `http://localhost:8080/`
Image-Name: webserver Container-Name: web

```
# list running containers
docker ps

# list stopped containers
docker ps -a

# build image
docker build --no-cache -t webserver .

# to doublecheck creation-ts of image
docker images

# run container and publish port 8080
docker run -it --rm -d -p 8080:80 --name web webserver

# go into container
docker exec -ti web bash
chore 644 <filename>

# view logs
docker logs <container>
```
