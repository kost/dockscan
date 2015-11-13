dockscan
===========

![logo](https://raw.githubusercontent.com/kost/dockscan/master/docs/dockscan.png)

Scan Docker installations for security issues and vulnerabilities.


## Features

- plugin based system for discovery, audit and reporting
- able to scan local and remote docker installations
- plugins are easy to write


## Requirements

- Ruby
- Ruby gem: docker-api (docker)


## Usage

Typical usage for scanning docker installation.

If you wish to scan local Docker installation:

`dockscan.rb unix:///var/run/docker.sock`

If you wish to scan remote Docker installation and produce HTML report:

`dockscan.rb -r html -o myreport -v tcp://example.com:5422`

If you wish to scan remote Docker installation and produce text report:

`dockscan.rb -r txt -o myreport -v tcp://example.com:5422`


## Environment variables

DOCKER_CERT_PATH will configure dockscan to use SSL

DOCKER_SSL_VERIFY if set to false will not verify certificates.


### ToDo
- [ ] Implement web frontend for scanner
- [ ] Progress bars

### Done
- [x] Different reporting (HTML, txt, ...) 

