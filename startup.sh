#!/bin/bash

source ~/.bashrc

set -x
nginx
cd /root/app
bundle exec puma -C config/puma.rb
