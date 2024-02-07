#!/bin/bash

wget https://github.com/ajanis/spoctunnel/archive/$1.tar.gz -O releases/$1.tar.gz
shasum -a 256 releases/$1.tar.gz