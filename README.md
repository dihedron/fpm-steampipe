# fpm-steapipe

Produce DEBs and RPMs for steampipe.

## Why?

Steampipe.io suggests the package be installed via piping a downloaded script into a shell as root. This is a bad practice from a security standpoint and it's incompatible with airgapped installations.
The `install.sh` script on their website is very easy to inspect; it:

1. downloads the appropriate package for the current operating system, 
1. extracts the single binary under a temporary directory, and 
1. copies it under `/usr/local/bin`.

RPMs and DEBs can do the same while leaving the information that Steampipe is installed in the system package database, e.g. for auditing purposes.

## How?

Run `make deb` on Debian derivatives, `make rpm` for Red Hat derivatives. Then install with the appropriate operating system tools.  