VERSION=0.18.2
NAME=steampipe-sddc
MAINTAINER=maintainer@example.com
VENDOR=vendor@example.com
LICENSE="AGPLv3"
RELEASE=1
PRODUCER_URL=https://steampipe.io/
DOWNLOAD_URL=https://github.com/turbot/steampipe/releases/download

steampipe_linux_amd64.tar.gz:
	@wget $(DOWNLOAD_URL)/v$(VERSION)/steampipe_linux_amd64.tar.gz

.phony: deb
deb: steampipe_linux_amd64.tar.gz
	@fpm -s tar -t deb --prefix /usr/local/bin --name $(NAME) --version $(VERSION) --iteration $(RELEASE) --description "Steampipe - Query the cloud with SQL" --vendor $(VENDOR) --maintainer $(MAINTAINER) --license $(LICENSE) --url $(PRODUCER_URL) --deb-compression bzip2 steampipe_linux_amd64.tar.gz

.phony: rpm
rpm: steampipe_linux_amd64.tar.gz
	@fpm -s tar -t rpm --prefix /usr/local/bin --name $(NAME) --version $(VERSION) --iteration $(RELEASE) --description "Steampipe - Query the cloud with SQL" --vendor $(VENDOR) --maintainer $(MAINTAINER) --license $(LICENSE) --url $(PRODUCER_URL) steampipe_linux_amd64.tar.gz

.phony: clean
clean:
	@rm -rf $(NAME)_$(VERSION)-$(RELEASE)_amd64.deb
	@rm -rf $(NAME)_$(VERSION)-$(RELEASE)_amd64.rpm

.phony: reset
reset: clean
	@rm -rf steampipe_linux_amd64.tar.gz 

.phony: help
help:
	@echo "make setup       - install FPM and other tools"
	@echo "make deb         - create a DEB package"
	@echo "make rpm         - create a RPM package"
	@echo "make clean       - remove the DEB or RPM file"
	@echo "make reset       - remove the downloaded archive"
	@echo "make install     - install the package"
	@echo "make remove      - remove the package"

# see http://linuxmafia.com/faq/Admin/release-files.html
.phony: setup
setup:
ifneq (,$(wildcard /etc/lsb-release))
	@echo "Setting up prerequisite tools for Ubuntu or Mint Linux"
	sudo apt-get update && sudo apt-get install ruby-dev build-essential && sudo gem install fpm
else ifneq (,$(wildcard /etc/debian_version)) 
	@echo "Setting up prerequisite tools for Debian Linux (TODO)"
else ifneq (,$(wildcard /etc/redhat-release)) 
	@echo "Setting up prerequisite tools for Red Hat Enterprise Linux"
	yum install -y wget ruby rpm-build && gem install fpm
else ifneq (,$(wildcard /etc/fedora-release))
	@echo "Setting up prerequisite tools for Fedora Linux (TODO)"
endif
