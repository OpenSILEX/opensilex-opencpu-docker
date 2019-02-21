FROM opencpu/rstudio

RUN apt-get update

RUN apt-get install -y libgit2-dev 

RUN R -e 'install.packages("devtools");devtools::install_github("sanchezi/phisWSClientR", build_vignettes=TRUE)'

RUN R -e 'install.packages("ggplot2");install.packages("plotly");'

RUN R -e 'install.packages("dyplr");install.packages("openssl");'

EXPOSE 8004/tcp
