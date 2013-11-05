#!/bin/bash

# Our deploy script

set -e
set -x

#
# Get our latest code
#
if [[ ! -d app ]]; then
  git clone https://github.com/kennethkalmer/powerdns-on-rails app
fi

mkdir -p tmp/deploy

cd app
git pull
git archive --format=tar master | (cd ../tmp/deploy && tar xf -)
cd -

# Now use docker to build the image
docker build -t deploy:latest .

rm -f tmp/cid

# Get our bundle going
docker run -cidfile tmp/cid -t deploy:latest /usr/bin/app-shim bundle
docker commit `cat tmp/cid` deploy latest
rm -f tmp/cid

# 
# Set DATABASE_URL for the tests
# 

# Now run our tests
docker run \
  -e DATABASE_URL=postgres://root:testing@localhost/app_testing
  -cidfile tmp/cid \
  -t deploy:latest \
  /usr/bin/app-shim bundle exec rake db:create test:prepare spec --trace
docker commit `cat tmp/cid` deploy latest
