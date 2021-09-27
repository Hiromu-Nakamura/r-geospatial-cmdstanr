# Docker image/container for R-Geospatial with CmdStan

Docker image with CmdStan created top of R-Geospatial.

This image is based on [rocker/geospatial](https://hub.docker.com/r/rocker/geospatial/tags)

## Prerequisities

In order to run this container you'll need docker installed.

Only Windows version are tested.

* [Windows](https://docs.docker.com/windows/started)

Probably works with Mac and Linux as well, but not tested.

## Usage

### Packages installed
In addtion to the rocker/geospatial packages, this image is installed following packages and its dependencies:

* posterior
* bayesplot
* cmdstanr

CmdStan is installed as well. You do not need to run `cmdstanr::install_cmdstanr()` function.

### Volumes
Volumes mounted to the container is specified in `docker-compose.yml`. Please change the `volumes` part to your original one.

### User settings
User settigs are controled by rstudio-prefs.json file.

### How to run
Run the `docker-compose up`. RStudio Server will start up automatically, then access to localhost:8787/ via browser.
**Note: Authentication step is disabled. You should not use this image in publicly accessible environment**

### Author

* Hiromu Nakamura

### License

The codes inside of this project are released under the MIT License, see [LICENSE.md](LICENSE.md).