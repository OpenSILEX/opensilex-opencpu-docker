# Use builds from launchpad
FROM opencpu/rstudio

RUN apt-get update && apt-get install -y libgit2-dev apt-utils

RUN R -e 'install.packages("devtools");devtools::install_github("niio972/phisWSClientR", build_vignettes=TRUE)' 
RUN R -e 'library("devtools");devtools::install_github("niio972/opencpu-webapp")'   

EXPOSE 8004/tcp
