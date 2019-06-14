
# Use builds from launchpad
FROM opencpu/rstudio

# default password
ENV USER_PASSWORD=opencpu

RUN apt-get update

RUN apt-get install -y libgit2-dev 

# custom password on run
RUN echo "opencpu:${USER_PASSWORD}"| chpasswd

USER opencpu

# R client
RUN R -e 'remotes::install_github("openSILEX/phisWSClientR", build_vignettes=TRUE,ref="v1.3.0",upgrade ="always")'

# example application
RUN R -e 'opencpu::install_apps("openSILEX/opensilex-datavis-rapp-demo")'

USER root

EXPOSE 8004/tcp
