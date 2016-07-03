#!/usr/bin/env bash

# Yimeng Zhang, 2016

# create a default Python 2 environment for the lab,
# with all important things.
# roughly following https://www.scipy.org/stackspec.html, without Sympy.
conda create -n default -y python=2 numpy scipy matplotlib pandas nose ipython jupyter