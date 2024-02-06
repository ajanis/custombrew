#!/bin/bash

wget https://github.com/ajanis/sshuttle-spoc-helper/archive/$1.tar.gz -O releases/$1.tar.gz
shasum -a 256 releases/$1.tar.gz