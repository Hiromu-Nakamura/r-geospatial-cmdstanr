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
        DataExplorer \
    && install2.r --error --deps TRUE --repos https://mc-stan.org/r-packages/ cmdstanr \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
    && mkdir /home/rstudio/.cmdstanr/ \
    && Rscript -e "cmdstanr::install_cmdstan(dir = '/home/rstudio/.cmdstanr/', cores = 2)" \
    && Rscript -e "cmdstanr::set_cmdstan_path(path = '/home/rstudio/.cmdstanr/cmdstan-2.28.0')" \
    && chown rstudio -R /home/rstudio/

CMD ["/init"]