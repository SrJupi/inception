# Inception

## Project Overview

The infrastructure consists of the following services:
* Nginx: Acts as a reverse proxy and the only entry point to the infrastructure, serving traffic over HTTPS with TLSv1.2 or TLSv1.3.
* WordPress: Installed and configured with PHP-FPM.
* MariaDB: Database used for storing WordPress data.

## Features

* Custom Dockerfiles for each service built from Debian.
* Containers restart in case of failure.
* Health checks implemented for MariaDB and WordPress.
* Persistent storage using Docker volumes for the database and WordPress files.
* Services communicate via a custom Docker network.
* Environment variables for sensitive data, stored in a .env file.

## Directory Structure

``` bash
.
├── Makefile
├── README.md
└── srcs
    ├── docker-compose.yml
    └── requirements
        ├── mariadb
        │   ├── conf
        │   ├── Dockerfile
        │   └── tools
        │       ├── entry.sh
        │       └── health.sh
        ├── nginx
        │   ├── conf
        │   │   └── nginx.conf
        │   ├── Dockerfile
        │   └── tools
        └── wordpress
            ├── conf
            │   └── www.conf
            ├── Dockerfile
            └── tools
                ├── health.sh
                └── wp.sh
```

## Requirements

* Docker and Docker Compose must be installed.
* All images are built from Debian, no pre-built images from external sources are allowed.
* The domain must be configured to point to login.42.fr (replace login with your username).

## Installation

* Clone the repository:

``` bash

git clone https://github.com/your-repo.git
cd your-repo

```

Create a .env file at the src folder and configure the environment variables as follows:

``` makefile

# MYSQL SETUP
MYSQL_DB=wordpress # database name
MYSQL_USER=db_user # database user
MYSQL_PASSWORD=db_pass # database user password
MYSQL_ROOT_PASSWORD=db_root_pass # root password

# WP SETUP
DOMAIN_NAME=localhost # domain name of the website
WP_ADMIN_N=admin # admin name
WP_ADMIN_P=admin_password # admin password
WP_TITLE="Your Website Title" # website title
WP_ADMIN_E=admin@example.com # admin email

# WP NEW USER SETUP
WP_U_NAME=new_user # user name of the new user
WP_U_PASS=user_password # user password
WP_U_ROLE=author # author, editor, administrator ...
WP_U_EMAIL=user@example.com # user email

```

Replace the placeholders with your actual configuration.

Build and start the containers:

``` bash

make

```

Access the WordPress site at: https://login.42.fr (replace login with your username).

## Health Checks

* MariaDB: Uses a health check script to ensure the database is running correctly.
* WordPress: Health checks verify the installation is functioning properly.

## Notes

* Nginx is configured to only accept connections on port 443 using secure protocols.
* No passwords or sensitive data are hardcoded into Dockerfiles; all credentials are managed through environment variables.


## Resources

[How to Create Custom Nginx Docker Image ](https://plainenglish.io/blog/how-to-create-custom-nginx-docker-image)

[Control startup and shutdown order in Compose](https://docs.docker.com/compose/startup-order/)

[Docker Compose Restart Policies](https://www.baeldung.com/ops/docker-compose-restart-policies)

[How better management of processes in Docker can greatly improve a container’s lifecycle](https://cloud.theodo.com/en/blog/docker-processes-container)
