# Use builds from launchpad
FROM opencpu/base

RUN groupadd -g 998 appuser && \
    useradd -r -u 998 -g appuser appuser
USER appuser

RUN apt-get update && apt-get install -y libgit2-dev apt-utils

# RUN R -e 'install.packages("devtools");devtools::install_github("sanchezi/phisWSClientR", build_vignettes=TRUE)' 
    
# RUN R -e 'install.packages("ggplot2");install.packages("plotly");' 
    
# RUN R -e 'install.packages("dyplr");install.packages("openssl");devtools::install_github("niio972/opencpu-webapp")'


# Install development tools
RUN \
  sudo apt-get install -y rstudio-server r-base-dev sudo curl git libcurl4-openssl-dev libssl-dev libxml2-dev libssh2-1-dev

# Workaround for rstudio apparmor bug
RUN echo "server-app-armor-enabled=0" >> /etc/rstudio/rserver.conf

RUN service cron start 

CMD sudo /usr/lib/rstudio-server/bin/rserver && sudo apachectl -DFOREGROUND

EXPOSE 8004/tcp
