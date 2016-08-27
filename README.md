[![Build Status](https://travis-ci.org/kost/dockscan.png)](https://travis-ci.org/kost/dockscan)
[![Coverage Status](https://coveralls.io/repos/kost/dockscan/badge.png?branch=master)](https://coveralls.io/r/kost/dockscan?branch=master)

dockscan
===========

![logo](https://raw.githubusercontent.com/kost/dockscan/master/docs/dockscan.png)

Scan Docker installations for security issues and vulnerabilities.


## Features

- plugin based system for discovery, audit and reporting
- able to scan local and remote docker installations
- plugins are easy to write


## Requirements

- Ruby 2.0 or above (1.9.x does not work!)
- Ruby gem: docker-api (docker)


## Installation

You can install dockscan by installing dockscan gem:

`gem install dockscan`

## Usage

Typical usage for scanning docker installation.

If you wish to scan local Docker installation:

`dockscan unix:///var/run/docker.sock`

If you wish to scan remote Docker installation and produce HTML report:

`dockscan -r html -o myreport -v tcp://example.com:5422`

If you wish to scan remote Docker installation and produce text report:

`dockscan -r txt -o myreport -v tcp://example.com:5422`


## Environment variables

DOCKER_CERT_PATH will configure dockscan to use SSL

DOCKER_SSL_VERIFY if set to false will not verify certificates.


### ToDo
- [ ] Implement web frontend for scanner
- [ ] Progress bars

### Done
- [x] Different reporting (HTML, txt, ...) 

