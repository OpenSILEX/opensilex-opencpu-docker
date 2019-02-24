# Use builds from launchpad
FROM opencpu/rstudio

RUN apt-get update

RUN apt-get install -y libgit2-dev 

RUN R -e 'remotes::install_github("niio972/phisWSClientR", build_vignettes=TRUE)'

RUN R -e 'opencpu::install_apps("OpenSILEX/variablesStudy")'

EXPOSE 8004/tcp
