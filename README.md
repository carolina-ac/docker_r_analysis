# Using Docker for R-based Data Analysis

## Introduction

This Docker container is designed to provide a reproducible environment for running R-based data analysis, specifically related to a project that uses packages like **covarianceSelection**, **biomaRt**, and various other CRAN and Bioconductor packages. The Dockerfile helps automate the setup of the necessary dependencies and packages for R projects.

## What is Docker?

Docker allows you to create isolated environments (containers) that package an application and its dependencies together. This ensures that the environment is consistent across different machines, making your project more reproducible.

### Why use this Docker image?

- **Reproducibility**: The Docker container ensures that everyone working on this project has the same environment with the exact versions of the required R packages.
- **Easy Setup**: No need to manually install dependencies on your machine. The Docker container automatically sets up everything you need.
- **Portability**: The Docker container can be run on any machine that has Docker installed, regardless of the underlying operating system.

## Dockerfile Overview

The Dockerfile provided sets up an R environment based on the **Rocker** image (version 4.1.2). Here's a summary of what the Dockerfile does:

1. **Base Image**: It uses the official `rocker/r-ver:4.1.2` image, which includes R version 4.1.2.
2. **System Dependencies**: Installs necessary system libraries like `libgit2-dev`, `libxml2-dev`, and others.
3. **R Packages**: Installs important R packages such as `DBI`, `glmnet`, `igraph`, and `covarianceSelection`, among others.
4. **Bioconductor Packages**: Installs the Bioconductor package `org.Hs.eg.db` for genome annotations.
5. **Working Directory**: Sets the working directory to `/path/to/your/local/directory`* for running your scripts.

## How to Use the Docker Container

### Prerequisites

- **Docker installed**: Ensure that you have Docker installed on your system. You can download Docker from the official [Docker website](https://www.docker.com/get-started).

### Steps to Build and Run the Docker Container

#### 1. Build the Docker Image:

   Open a terminal and navigate to the folder containing the `Dockerfile`. Run the following command to build the Docker image:

   ```bash
   docker build -t r_project_image .

   ```

#### This command will download the base image, install the necessary dependencies, and create a Docker image named r_project_image.

#### 2. **Run the Docker Container:**

When you modify your scripts, you can use the `docker run` command to mount your updated local directory inside the container. This ensures that the container has access to the latest version of your R scripts.

Run the following command in your terminal:

```bash
docker run -v /path/to/your/local/directory:/path/inside/container -it r_project_image
```
* -v: This option mounts your local directory (where your R scripts are stored) to a directory inside the Docker container. In this case, /path/to/your/code:/usr/src/app/directory is the local path, and /usr/src/app/directory is the directory inside the container.
* -it: Runs the container in interactive mode, so you can interact with it as if it were a regular terminal.
* r_project_image: This is the Docker image that contains your R environment. Replace this with the actual name of your Docker image.

## Running the R Script Inside the Docker Container

#### 1. Start the R session or use Rscript:
To run the script using source(), first enter the R console by typing:

```
R
```

#### 2. Source your R script:

Once inside the R environment, you can run your R script using the source() function:

```
source("your_script.R")  # Replace "your_script.R" with your actual script name
```
This command will execute the R script

#### 3. Exit the Container
Once your R script has finished running, you can exit the container by typing:
```
exit
```
This will close the interactive terminal session and stop the container.

### Additional Notes

* If you need to rerun the container with updated scripts, simply make changes to the R script locally, and rerun the docker run command. Since the local directory is mounted as a volume, Docker will always have access to the most recent version of your scripts.
* The -it flag allows you to interact with the container as if it were a regular terminal session, giving you flexibility to run commands and inspect your environment.

## * Important
It’s important to note that `/path/inside/container` is a placeholder. To use the Dockerfile, you need to replace it with the directory inside the container where you want your files to be accessible.
For example, if you mount your local directory to `/usr/src/app/CA_original` inside the container, then the correct version would be:

WORKDIR /usr/src/app/CA_original

Your files should be mounted in this path when running the container.

To run the Docker:

```
docker run --rm -v /mnt/f/open_git/R/cac/CA_original:/usr/src/app/CA_original -w /usr/src/app/CA_original -it r_project_image bash
```
