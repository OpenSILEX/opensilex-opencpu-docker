FROM opencpu/rstudio

RUN groupadd -g 999 appuser && \
    useradd -r -u 999 -g appuser appuser
USER appuser

RUN apt-get install -y libgit2-dev 

RUN R -e 'install.packages("devtools");devtools::install_github("sanchezi/phisWSClientR", build_vignettes=TRUE)'

RUN R -e 'install.packages("ggplot2");install.packages("plotly");'

RUN R -e 'install.packages("dyplr");install.packages("openssl");'

EXPOSE 8004/tcp
