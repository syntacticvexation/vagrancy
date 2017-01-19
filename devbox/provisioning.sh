#!/bin/bash

sudo DEBIAN_FRONTEND=noninteractive apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get \
     -o Dpkg::Options::="--force-confold" \
     -o Dpkg::Options::="--force-confdef" \
     --yes --force-yes \
     install ruby curl
curl -sSL https://get.rvm.io | bash -s stable --ruby
source $HOME/.rvm/scripts/rvm
rvm use 2.2.2 --install --binary --fuzzy
gem install bundler

cd /vagrancy
export BUNDLE_GEMFILE=$PWD/Gemfile
bundle install --with=development
bundle exec rspec --color --format documentation spec/

rake package:linux:x86_64
rake package:linux:x86
rake package:osx
