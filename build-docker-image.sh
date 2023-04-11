#!/usr/bin/env bash
(
cd docker
make version=3.1.33 alias=latest image_name=jarnoharno/emsdk build test $1
)
