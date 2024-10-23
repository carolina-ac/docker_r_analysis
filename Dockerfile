# Use a base image of R
FROM rocker/r-ver:4.1.2

# Add necessary system dependencies
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libgit2-dev \
    build-essential \
    git \
    libxml2-dev \
    libfontconfig1-dev \
    && apt-get clean

# Install CRAN packages
RUN R -e "install.packages(c('DBI', 'devtools', 'doMC', 'foreach', 'glmnet', 'hash', 'huge', 'igraph', 'MASS', 'Matrix'), repos='https://cloud.r-project.org/')"

# Install remotes package to install packages from GitHub
RUN R -e "install.packages('remotes', repos='https://cloud.r-project.org/')"

# Install Bioconductor packages (org.Hs.eg.db)
RUN R -e "if (!requireNamespace('BiocManager', quietly = TRUE)) install.packages('BiocManager'); BiocManager::install('org.Hs.eg.db')"

# Install dequer from the CRAN Archive
RUN R -e "install.packages('https://cran.r-project.org/src/contrib/Archive/dequer/dequer_1.0.tar.gz', repos=NULL, type='source')"

# Install covarianceSelection from GitHub
RUN R -e "remotes::install_github('linnylin92/covarianceSelection', subdir = 'covarianceSelection')"

# Try installing gprofiler2 from CRAN
RUN R -e "install.packages('gprofiler2', repos='https://cloud.r-project.org/')"

# Install additional CRAN packages
RUN R -e "install.packages(c('knitr', 'ggplot2', 'dplyr', 'biomaRt', 'readr', 'R.utils', 'mixtools'), repos='https://cloud.r-project.org/')"

# Set the working directory in the container
# Your files should be mounted in this path when running the container. Replace it with your path
WORKDIR /path/inside/container


# Do not copy files as we will use volumes for mapping
