#!/bin/bash -e

CONFIG_FILE = ../config.json

all: install serve

venv:
	virtualenv venv

serve:
	echo "Starting Flask server..."
	. venv/bin/activate; python run.py

install: venv dependencies configure bootstrap runner
	@echo '@@@ INSTALL SUCCESS @@@'
	@echo '@@@ INSTALL SUCCESS @@@'
	@echo '@@@ INSTALL SUCCESS @@@'

runner:
	mkdir -p ~/workspace/.c9/runners
	touch ~/workspace/.c9/runners/Bootcamp.run
	echo '{"cmd":["make","serve"],"info":"Started $$project_path$$file_name","env":{},"selector":"source.ext"}' > ~/workspace/.c9/runners/Bootcamp.run

dependencies:
	echo "Upgrading pip"
	. venv/bin/activate; pip install --upgrade pip
	echo "Resolving Python dependencies..."
	. venv/bin/activate; pip install --upgrade -r requirements.txt

configure:
	echo "Setting configuration..."
	. venv/bin/activate; python configure.py $(CONFIG_FILE)

bootstrap:
	echo "Bootstrapping app..."
	. venv/bin/activate; python bootstrap.py $(CONFIG_FILE)

clean:
	echo "Deleting configuration file..."
	rm -f $(CONFIG_FILE)
