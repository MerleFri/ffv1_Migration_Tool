# ffv1MigrationTool: Rosetta Migration Plugin

This script plugin migrates audiovisual files to ffv1-Video, Version 3, Matroska with LPCM-Audio.
The number of Slices per Frame is either default or can be manipulated by custom parameters.

## Getting Started

### Prerequisites

install [FFmpeg](https://www.ffmpeg.org/) on the server

### Installing

see [Rosetta SDK](https://developers.exlibrisgroup.com/rosetta/integrations/plugins/), Deployment and Installation

## Running the Plugin

While preservation planning, choose the ffv1MigrationTool as internal plugin.
You can either give no parameter (default) or work with a custom parameter.

### default

When no parameter is entered, the plugin runs with default profile.
This means a slice number of 16 slices.

### custom parameter

The following are valid custom parameters:
* 4 - leads to 4 slices per frame
* 6 - leads to 6 slices per frame
* 9 - leads to 9 slices per frame
* 12 - leads to 12 slices per frame
* 16 - leads to 16 slices per frame
* 24 - leads to 24 slices per frame
* 30 - leads to 30 slices per frame


### error codes

if migration was not successfull, an error code appears in the log
* 2 - no valid custom parameter
* 3 - more than one custom parameter, only one allowed
* other - error code from FFmpeg, migration failed althoug custom parameter was correct


## Authors

* **Merle Friedrich** - *German Nation Library of Science and Technology (TIB)*

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
