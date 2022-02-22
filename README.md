# Mobile Systeme [MOB] Semesterprojekt




[![pipeline status](https://gitlab.iue.fh-kiel.de/jascha.hirsekorn/mob-app/badges/main/pipeline.svg)](https://gitlab.iue.fh-kiel.de/jascha.hirsekorn/mob-app/-/commits/main)
[![coverage report](https://gitlab.iue.fh-kiel.de/jascha.hirsekorn/mob-app/badges/main/coverage.svg)](https://gitlab.iue.fh-kiel.de/jascha.hirsekorn/mob-app/-/commits/main)

## Description
This repository contains all code, documentation and build system configuration for the project. The goal was to build an app for mobile devices that displays news and information about football matches to the User.

Note however that neither of the authors knows anything about football. As such the challenge was of considerable difficulty.

## Installation & Usage Instructions

APK builds are available through our CI build system. To obtain the latest build, please go to `CI/CD > Pipelines > Tags`, find the newest tag, then click on the three dots next to the pipeline entry and select the `build:archive` option.  
Note that APK builds are only performed for tagged commits in order to not overstress the build server.

**For usage instructions please consult the wiki.**

## Code Structure

Because of the unique way the Flutter initializer script works, the project is contained within a separate `mob_app` directory in the root of the repository, safe for CI script and editor configuration.

All application code lives in `/lib`. Application entry point is provided in `/lib/main.dart`, with various other utility files living on the same directory level. `lib/views` contains all individual Routes used in the frontend of the app. `lib/auth` contains the authentication system, including implementation of the different authentication providers. `lib/models` contains storage models used by the storage system, which can be found in `lib/storage`. Both `storage` and `auth` follow similar structural designs with abstract classes located in the root directory and concrete implementations for providers in the `providers` subdirectory.

Within `lib/views`, some views may be grouped together logically in their own subdirectories for ease of use.

Tests for the application are contained within `/test`. All tests are run automatically on any push to a public branch, see pipeline status for more information.

The other directories contain build files for various target platforms. Note that at the time of writing, we only support the Android platform. 
