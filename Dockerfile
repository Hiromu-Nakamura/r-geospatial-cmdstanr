ARG cmdstan_path="/home/rstudio/.cmdstan"

FROM rocker/geospatial:latest

LABEL maintainer="Hiromu Nakamura"
LABEL description="Docker container with CmdStan based on rocker/geospatial"

ENV LANG ja_JP.UTF-8

COPY ./rstudio-prefs.json /home/rstudio/.config/rstudio/rstudio-prefs.json

RUN apt-get update \
    && apt-get install -y \
        locales \
        fonts-ipaexfont \
    && localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8 \
    && apt-get clean \
    && install2.r --error --deps TRUE \
        posterior \
        bayesplot \
    && Rscript -e "install.packages('cmdstanr', repos = c('https://mc-stan.org/r-packages/', getOption('repos')))" \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
    && chown rstudio /home/rstudio/.config/rstudio/rstudio-prefs.json

USER rstudio
WORKDIR /home/rstudio
RUN Rscript -e "cmdstanr::install_cmdstan(cores = 2)"

USER root