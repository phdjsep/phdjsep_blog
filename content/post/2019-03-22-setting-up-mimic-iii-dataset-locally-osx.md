---
title: Setting up MIMIC-III dataset locally (OSX)
author: Sep Dadsetan
date: '2019-03-22'
slug: setting-up-mimic-iii-dataset-locally-osx
categories:
  - Engineering
tags:
  - rstats
  - healthcare
---

I wanted a local dataset to begin messing around with deep learning (and whatever the next hot technology will be in 6 months lol). Since most of my time is spent on electronic medical record (EMR) data, I decided to set out on finding a free dataset that I could leverage for my experimentations. Since I had to bounce around the net combining pieces of information to make this thing operational, I decided to write this post for myself and perhaps the passerby.

Requirements for dataset:
    
- Free
- Can't be too large
- Setup should be easy

Thankfully a quick search and I came across the [MIMIC dataset](https://mimic.physionet.org/) put together by the MIT Lab for Computational Physiology. This is a deidentified dataset of over 40,000 critical care patients and contains all sorts of information such as lab tests, medications, demographics, etc. It's free, not too large (90GB when all said and done), and can be setup relatively easily thanks to the wonderful support they already provide!

{{<figure src="https://media.giphy.com/media/l3q2LH45XElELRzRm/giphy.gif" caption="Perfect" width="480" height="326">}}

I followed instructions in the documentation to request access by filling out the necessary information and taking the required HIPAA training. 


*Note: I'm glad they require the training because eventhough the data is deidentified, I'm sure with enough grit something identifiable could be derived from it and it's nice to make sure users are held to a standard.*


So once I received access it just then became a matter of how I wanted to set up the dataset. The website linked above is very helpful in describing the dataset and providing information on how to download and/or setup a database so it was fairly painless. The repository on [Github](https://github.com/MIT-LCP/mimic-code/) has a `buildmimic` folder with several options baked in. I went with the common Postgres install.


*Note: instructions are geared toward OSX and assume you have about 100GB of disk space available*


First things first, make sure you have Postgres installed. This can be checked with a simple `which postgres` in Terminal. If it comes back with nothing, then we'll have to get Postgres installed. Easiest way to do this, in my opinion, is to use [homebrew](https://brew.sh/). If that's not installed on your computer then I recommend just following along on their website and coming back here.

Assuming `brew` is installed, then I've put together a little gist to help out. Feel free to reach out if you have questions and I'll see if I can help.

{{<gist phdjsep d9b0bc48e6eec78e61bb0fe7da32d534 >}}

So after following the above gist, you should have a functional postgres set up. Yay! Let's go ahead and move forward with getting the MIMIC code, data, and subsequently loading it into our local postgres.

1. First we need to create a `postgres` user. 
This will make things easier when loading the MIMIC data. To do so, go to your Terminal and run: `/usr/local/opt/postgres/bin/createuser -s postgres`
2. Clone the MIMIC repository (assumes `git` is installed. If not `brew install git`).
Find a place on your local system that you want to keep the code and in your Terminal run `git clone https://github.com/MIT-LCP/mimic-code.git`. This will "clone" the code to your local system so we can leverage the wonderful work the folks at MIT have already done.
3. Retrieve the data (assumes `wget` is installed. If not `brew install wget`).
Find somewhere you'll want to store the data (in gzipped format) and in your Terminal run:
`wget --user <USERNAME> --ask-password -A csv.gz -m -p -E -k -K -np -nd https://physionet.org/works/MIMICIIIClinicalDatabase/files/`
4. Load the data.
You'll now need to `cd` into the MIMIC code repository we cloned and specifically into the `buildmimic/postgres` directory. From there you can run the: `make create-user mimic-gz datadir="/PATH/TO/THE/DATA"` command. *Note: This will take several hours to run (depending on your system). It's recommended to do this overnight and to use something like `caffeine` (If not installed: `brew cask install caffeine`)*

At the end of that script should be a database check and you should be ready to use the database! Feel free to reach out if you have questions and I'll do my best. :)