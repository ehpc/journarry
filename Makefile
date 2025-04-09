# Favicons directory
ASSETS_FAVICON_DIR := assets/favicon

# Detecting OS and generating OS-specific commands
OSFLAG :=
INSTALL_CMD :=
ifeq ($(OS),Windows_NT)
	OSFLAG = WINDOWS
	INSTALL_CMD := winget install --id=Gyan.FFmpeg -e && winget install --id=Shssoichiro.Oxipng -e || exit 0
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		OSFLAG = LINUX
		INSTALL_CMD := sudo apt install ffmpeg oxipng
	endif
	ifeq ($(UNAME_S),Darwin)
		OSFLAG = MACOS
		INSTALL_CMD := brew install ffmpeg oxipng
	endif
endif

# Generate favicon of all sizes
.PHONY: favicon
favicon:
	ffmpeg -y -i $(ASSETS_FAVICON_DIR)/favicon-512.png -vf crop=256:256:117:106 $(ASSETS_FAVICON_DIR)/favicon-cropped.png
	ffmpeg -y -i $(ASSETS_FAVICON_DIR)/favicon-cropped.png -vf scale=32:32 $(ASSETS_FAVICON_DIR)/favicon.ico
	ffmpeg -y -i $(ASSETS_FAVICON_DIR)/favicon-512.png -vf scale=180:180 $(ASSETS_FAVICON_DIR)/apple-touch-icon.png
	ffmpeg -y -i $(ASSETS_FAVICON_DIR)/favicon-512.png -vf scale=192:192 $(ASSETS_FAVICON_DIR)/favicon-192.png

# Assets optimization
.PHONY: optimize-assets
optimize-assets:
	oxipng -o max --strip safe -r $(ASSETS_FAVICON_DIR)

# Build everything
.PHONY: build-all
build-all:
	make favicon
	make optimize-assets

# Print OS
.PHONY: os
os:
	@echo $(OSFLAG)

# Install build tools
.PHONY: install
install:
	$(INSTALL_CMD)
	@echo Please restart your terminal...

# Help
.PHONY: help
help:
	@echo Available commands:
	@echo   install          - Install build tools
	@echo   build-all        - Build everything
	@echo   favicon          - Generate all favicons
	@echo   optimize-assets  - Optimize all assets recursively
	@echo   os               - Print OS

.DEFAULT_GOAL := build-all
