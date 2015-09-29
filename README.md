DOCKER STACK
============

This is bat country!

Overview
--------

Deploy a container with a Rails/Rack application, that was produced by a CI/CD
pipeline of sorts.

TODO
----

- [ ] Have good solid base images ready (or Dockerfile's)
- [ ] Have a way to reliably get a checkout of the app into a container
- [ ] Have a reliable way to setup an environment for the container
- [ ] Run the tests in the container
- [ ] Commit and publish the container when the tests pass
- [ ] Deploy the container
- [ ] Switch load balancers over to new image
- [ ] Monitor for errors for short period
- [ ] Switch over to new container
- [ ] Kill older container

AUXILIARY INFRASTRUCTURE
-----------------------

- [ ] PostgreSQL container
- [ ] Hipache/redis container
- [ ] Docker registry container

WILD WEST
---------

Some random notes from our initial experiments

* Troubles with CoreOS running out of disk space.
* Might be easier building images on docker vagrant image, still deploy to CoreOS
* Setting up environment to run code (PATH especially)
