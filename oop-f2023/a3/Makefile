PKG_NAME=com.aaanh
CURRENT_DIR=$(shell basename $(shell pwd))
ZIP_FILE=$(CURRENT_DIR).zip
LOG_FILE=test-results.xml

# Define the zip command based on the platform
ifeq ($(OS),Windows_NT)
# SEVENZIP := $(shell where 7z 2>/dev/null)
  ZIP_COMMAND := 7z a -r $(ZIP_FILE) ./src ./Makefile ./pom.xml ./README.*
else
	ZIP_COMMAND := tar -zcvf $(ZIP_FILE) ./src ./Makefile ./pom.xml ./README.*
endif

.PHONY: clean build test run

default: clean clean-log build test run

# Clean the log files
clean-log:
	@rm -f $(LOG_FILE)
	@rm -f *.log


# Clean the project
clean:
	mvn clean
	@rm -rf output/**/* ./**/*.log

# Build the project
build:
	mvn compile

# Run tests
test:
	mvn test

# Run the Java application
run:
	mvn exec:java -Dexec.mainClass=$(PKG_NAME).CellListUtilization


debug: build run

# Zip source
zip:
	@echo "Zipping source files and folders..."
	cp ./docs/doc.pdf ./README.pdf
	$(ZIP_COMMAND)
	@echo "Done! Zip file: $(ZIP_FILE)"

# Specify dependencies between targets (if necessary)
build: clean

# Usage information
help:
	@echo "Available targets:"
	@echo "  clean   : Clean the project"
	@echo "  build   : Build the project"
	@echo "	 debug   : Clean, build, run the project"
	@echo "	 zip     : Zip source"
	@echo "  test    : Run tests"
	@echo "  run     : Run the Java application"
	@echo "  help    : Show this help message"