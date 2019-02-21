FROM opencpu/rstudio

RUN apt-get update

RUN apt-get install -y libgit2-dev 

RUN R -e 'remotes::install_github("niio972/phisWSClientR", build_vignettes=TRUE)'

RUN R -e 'remotes::install_github("niio972/opencpu-webapp", build_vignettes=TRUE)'

RUN R -e 'opencpu::ocpu_start_app("webapp")'

EXPOSE 8004/tcp
