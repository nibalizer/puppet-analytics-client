#!/bin/bash

virtualenv .tmp
source .tmp/bin/activate
pip install bashate
bashate *.sh
