# Running heatmapper locally with docker

## Build the docker image 

```
# This will take a long time (10-30min)
docker build -t heatmapper .
```

## Run the webserver container

```
# Create a local folder for logs
mkdir -p /tmp/shiny-server-logs

# In the root folder of this project
docker run --rm -p 3838:3838 \
         -v $PWD:/srv/shiny-server \
         -v /tmp/shiny-server-logs:/var/log/shiny-server \
         heatmapper
```

## Access the webserver locally

In a web browser goto:

- http://localhost:3838/

# Known issues

- xlsx support is currently disabled
- In Experession "Upload File" does not work, but you can upload a single file 
using the "Upload Multiple Files" option
- The webserver will as root, be careful

