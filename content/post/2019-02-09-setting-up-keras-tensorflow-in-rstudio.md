---
title: Setting up Keras/Tensorflow in RStudio
author: Sep Dadsetan
date: '2019-02-09'
slug: setting-up-keras-tensorflow-in-rstudio
categories:
  - RStudio
tags:
  - tensorflow
  - keras
  - python
---

+++ +++

I've recently grown more interested in understanding deep learning (DL) and so I purchased [Deep Learning in R from Manning Books](https://www.manning.com/books/deep-learning-with-r) along with its digital course taught by [@Rick_Scavetta](https://twitter.com/rick_scavetta). It's been very interesting and so naturally I was excited to try my hand at the "Hello, World!" of DL and play with the infamous MNIST dataset.

So I fired my local RStudio session and followed the 3 step instructions to setup [keras/tensorflow](https://keras.rstudio.com/):

1. `devtools::install_github("rstudio/keras")` (Assumes devtools is installed, if not: `install.packages("devtools")`)
2. `library(keras)`
3. `install_keras()`

Easy peezy, right? Unfortunately...Error.

`install_keras()` is quite flexible and does many things behind the scenes to try and make the installation process dead simple. Unfortunately for someone like me who already has some custom Python configurations (and old ones at that), I ran into a roadblock. 

Some background: `install_keras()` tries to determine the python tools (eg, pip, conda, virtualenv) you have available on your system to then proceed with install of keras and tensorflow. The thing it does first is to create a virtual environment which allows it to install all the fun python tools it needs. If you're not familiar with `virtualenv`, it can be an absolute life saver because it "walls off" the python software needed for a project from your global system. This is helpful to keep package dependencies consistent and prevent code from breaking because there's an unsupported function/feature/package. I highly recommend installing it (along with the helpful `virtualenvwrapper`). You can read more [here](https://virtualenv.pypa.io/en/latest/)

Back to my roadblock...`install_keras()` was failing during the install of tensorflow because of a pip issue. I thought this might be due to my virtualenv/pip configuration, so I attempted to install tensorflow on my own and then point RStudio environment to that, but wasn't successful. Very importantly, I stepped away from the problem, then came back and took a different approach. After some more exploration and research, it turns out that my global pip version (and virtualenv) was OLD. I ran a simple `pip install -U pip` and a `pip install -U virtualenv` to bring these packages up to speed. 

Unfortunately these then hung a the "Uninstalling..." phase of the upgrade which after a little more research turned out to be a permission issue to which `sudo pip install -U pip virtualenv` worked. Not my favorite to use sudo, but this is an artifact of setting python up years ago on my Mac. `install_keras()` now completed and my journey into DL can commence!

I hope this little tidbit helps others and at the very least acts as a reminder to future self :)