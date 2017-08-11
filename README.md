A Docker container that adds [ffmpeg](https://www.ffmpeg.org/) and [ghostscript](https://www.ghostscript.com/) to [rocker/geospatial](https://hub.docker.com/r/rocker/geospatial/)
----------------------------------------------------------------

[Docker](https://www.docker.com/) is a virtual computing environment that facilitates reproducible research---it allows for research results to be produced independent of the machine on which they are computed. Docker users describe computing environments in a text format called a "Dockerfile", which when read by the Docker software builds a virtual machine, or "container". Other users can then load the container on their own computers. Users can upload container images to [Docker Hub](https://hub.docker.com/), and the image for this Docker container is available at <https://hub.docker.com/r/bocinsky/bocin_base/>.

The Dockerfile in this repository uses [`rocker/geospatial:3.4.1`](https://hub.docker.com/r/rocker/geospatial/), which provides R, [RStudio Server](https://www.rstudio.com/products/rstudio/download-server/), the [tidyverse](http://tidyverse.org/) of R packages as its base image and adds several geospatial software packages ([GDAL](http://www.gdal.org/), [GEOS](https://trac.osgeo.org/geos/), and [proj.4](http://proj4.org/). The Dockerimage adds [ffmpeg](https://www.ffmpeg.org/) and [ghostscript](https://www.ghostscript.com/) to [rocker/geospatial](https://hub.docker.com/r/rocker/geospatial/).

#### Downloading and running the Docker container image

The commands below demonstrate three ways to run the docker container. In each, we use the `-v` argument to mount a local working directory to the Docker container. See this [Docker cheat sheet](https://github.com/wsargent/docker-cheat-sheet) for other arguments.

##### Run the docker container interactively with a terminal prompt

You can run the container in interactive mode with:

``` bash
docker run -w /asian_niche -it bocinsky/asian_niche:0.9.0 bash
```

The `asian_niche.R` script has been designed to be run from the shell using Python-style argument parsing. To run, simply enter `Rscript --vanilla asian_niche.R` at the shell prompt. Passing the `--vanilla` option runs the script in a "fresh" R environment. Run `Rscript asian_niche.R --help` to see all available options.

You can use the `exit` command to stop the container.

##### Run the analysis from within a Dockerized RStudio IDE

You can also host RStudio Server locally to use the RStudio browser-based IDE. Run:

``` bash
docker run -v [PATH TO LOCAL DIRECTORY]:[PATH TO CONTAINER MOUNT POINT] -p 8787:8787 bocinsky/bocin_base

#example
docker run -v /Users/bocinsky/git/asian_niche/:~/asian_niche/ -p 8787:8787 bocinsky/bocin_base
```

Then, open a browser (we find [Chrome](https://www.google.com/chrome/) works best) and navigate to "localhost:8787" or or run `docker-machine ip default` in the shell to find the correct IP address, and log in with **rstudio**/**rstudio** as the user name and password. In the explorer (lower right pane in RStudio), navigate to the container mount point.

#### Building the Docker container from scratch

If you wish to build the Docker container locally for this project from scratch, simply `cd` into the `asian_niche/` directory and run:

``` bash
docker build -t bocinsky/bocin_base .
```

The `-t` argument gives the resulting container image a name. You can then run the container as described above.
