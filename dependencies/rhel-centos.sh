#!/usr/bin/env bash

## Install CentOS dependencies
yum -y groupinstall 'Development Tools'
yum -y install wget