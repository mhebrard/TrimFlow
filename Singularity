BootStrap: debootstrap
OSVersion: bionic
MirrorURL: http://us.archive.ubuntu.com/ubuntu

# Build the image
# sudo singularity build TrimFlow.img Singularity

# Metadata
%labels
  Maintainer mhebrard
  Version v1

# image help
%help
  This image contain "Trim galore" and its dependencies.
  please refers to "http://github.com/mhebrard/TrimFlow" for more info.

# Actions executed on start in host
%setup
  echo "Setup !"

# Files serve in the image
#files

# Variables
#environment

# Actions executed on start in image
%post
  # Repositories
  apt-get install -qy software-properties-common
  add-apt-repository universe
  add-apt-repository ppa:linuxuprising/java
  apt-get update

  # Pip
  apt-get install -qy python-pip
  pip --version
  # Cutadapt
  pip install cutadapt
  cutadapt --version
  # Java
  apt-get install -qy debconf-utils
  echo "oracle-java10-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
  apt-get install -qy oracle-java10-installer
  java -version
  # FastQC
  apt-get install -qy fastqc
  fastqc -v
  # TrimGalore
  apt-get install -qy curl
  curl -fsSL https://github.com/FelixKrueger/TrimGalore/archive/0.4.5.tar.gz -o trim_galore.tar.gz
  tar xzf trim_galore.tar.gz
  rm trim_galore.tar.gz
  mv TrimGalore-0.4.5/trim_galore /usr/bin
  trim_galore -v

# singularity run image.img
%runscript
  echo "This image is meant to use with nextflow. "
  echo "Please refers to "http://github.com/mhebrard/TrimFlow" for more info."
