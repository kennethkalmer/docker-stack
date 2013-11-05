#!/bin/bash

set -e
set -x

# Get a postgres container
docker run -p 5432 jpetazzo/pgsql /init testing
