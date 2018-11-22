# ------------------------------------------------------------------------------
# Installs ros2 code for local development
# Based on: https://index.ros.org/doc/ros2/Linux-Development-Setup/
# ------------------------------------------------------------------------------

FROM ubuntu:bionic

MAINTAINER Ruben Alves "rubenanapu@hotmail.com"

ENV DEBIAN_FRONTEND noninteractive

# ------------------------------------------------------------------------------
# Setup locales
# ------------------------------------------------------------------------------
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && apt-get install -y locales
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
RUN export LANG=en_US.UTF-8
# ------------------------------------------------------------------------------
# Setup sources to be able to install some ROS packages.
# ------------------------------------------------------------------------------
RUN apt-get install lsb-release gnupg2 -y
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver hkp://pool.sks-keyservers.net --recv-key 0xB01FA116
# ------------------------------------------------------------------------------
# Install development tools
# ------------------------------------------------------------------------------
RUN apt update && apt install -y \
      build-essential \
      cmake \
      git \
      python3-colcon-common-extensions \
      python3-pip \
      python-rosdep \
      python3-vcstool \
      wget
# ------------------------------------------------------------------------------
# Install some pip packages needed for testing
# ------------------------------------------------------------------------------
RUN python3 -m pip install -U \
      argcomplete \
      flake8 \
      flake8-blind-except \
      flake8-builtins \
      flake8-class-newline \
      flake8-comprehensions \
      flake8-deprecated \
      flake8-docstrings \
      flake8-import-order \
      flake8-quotes \
      pytest-repeat \
      pytest-rerunfailures
# ------------------------------------------------------------------------------
# [Ubuntu 16.04] install extra packages not available or recent enough on Xenial
# ------------------------------------------------------------------------------
RUN python3 -m pip install -U \
      pytest \
      pytest-cov \
      pytest-runner \
      setuptools
# ------------------------------------------------------------------------------
# Install Fast-RTPS dependencies
# ------------------------------------------------------------------------------
RUN apt install --no-install-recommends -y \
      libasio-dev \
      libtinyxml2-dev
# ------------------------------------------------------------------------------
# Create `user` user.
# ------------------------------------------------------------------------------
RUN adduser --disabled-password --gecos "" user
# ------------------------------------------------------------------------------
# Get ROS2 code
# ------------------------------------------------------------------------------
RUN mkdir -p /home/user/ros2_ws/src
WORKDIR /home/user/ros2_ws
RUN wget https://raw.githubusercontent.com/ros2/ros2/release-latest/ros2.repos
RUN vcs import src < ros2.repos
# ------------------------------------------------------------------------------
# Install ROS2 dependencies
# ------------------------------------------------------------------------------
RUN rosdep init
RUN rosdep update
RUN rosdep install --from-paths src --ignore-src --rosdistro bouncy -y --skip-keys "console_bridge fastcdr fastrtps libopensplice67 rti-connext-dds-5.3.1 urdfdom_headers"
RUN chown user:user /home/user/ -R
# ------------------------------------------------------------------------------
# Removing useless packages
# ------------------------------------------------------------------------------
RUN apt-get clean
RUN apt-get autoremove -y
# ------------------------------------------------------------------------------
#
# ------------------------------------------------------------------------------
ENV DEBIAN_FRONTEND teletype
USER user
CMD ["bash"]
