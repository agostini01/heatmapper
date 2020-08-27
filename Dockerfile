FROM rocker/shiny

# Installing necessary system libraries
RUN apt update && \
    apt install libxml2-dev libssl-dev libtiff-dev libpng-dev libcurl4-openssl-dev curl  -y

# This speeds up compilation inside R packages
ENV MAKE="make -j4"

# Adding necessary R packages
# From repositories
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site 
RUN install2.r --error shiny shinyBS 
RUN install2.r --error gplots ggdendro jpeg png
RUN install2.r --error tiff ggplot2 ggtern 
RUN install2.r --error MASS reshape2 leaflet RColorBrewer raster 
RUN install2.r --error devtools 

 # Is cairo a real dependency?
RUN apt install libcairo2-dev libxt-dev -y
RUN install2.r --error Cairo 
RUN install2.r --error ape DT

# From github projects
RUN R -e "library(devtools); devtools::install_github('sbabicki/jscolourR'); devtools::install_github('ramnathv/htmlwidgets'); devtools::install_github('timelyportfolio/htmlwidgets_spin'); devtools::install_github('rstudio/d3heatmap')"

# To enable XLSX support we need perl's missing libraries
# This section installation increses the image size
# Thus I am leaving it commented for now

# cpan init
# cpan Bundle::Compress::Zlib
# cpan Spreadsheet::ParseExcel Spreadsheet::ParseXLSX
