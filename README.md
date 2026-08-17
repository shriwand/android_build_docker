# Android Build Docker

Docker environment for building Android (AOSP) with preconfigured dependencies.

## Overview

Reproducible Docker-based build environment for Android BSP development. Eliminates host dependency issues and ensures consistent builds.

## Features

- Preconfigured Android build dependencies
- Build scripts for AOSP operations
- Volume mounting for source/output
- Optimized for AOSP 10+

## Quick Start

```bash
# Build image
make build

# Run container
docker run -v /path/to/aosp:/aosp -it android-build:latest

# Build Android inside container
cd /aosp && source build/envsetup.sh && lunch aosp_arm64-userdebug && m -j$(nproc)
```

## Structure

```
├── Makefile           # Build targets
├── build_scripts/     # Helper scripts
│   ├── _make.sh      # Internal functions
│   └── example.sh    # Example build
└── dockerdata/
    ├── Dockerfile    # Image definition
    └── etc/          # Configs
```

## Requirements

- Docker 20.10+
- 100+ GB disk space
- 32+ GB RAM recommended

## License

MIT
