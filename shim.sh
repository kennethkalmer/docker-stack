#!/bin/bash

# Our shim to load rbenv and run code :)

set -e

# Get our environment up, just like a login shell
source /etc/profile

# Switch our ruby version
rbenv shell 2.0.0-p247

# Switch our CWD
cd /application

# Now pass our commands through
exec "$@"
