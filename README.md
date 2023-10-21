# OD Server

Rails 7 based download server.

Makes use of basic open source tools to download data from various sources:
  - Standard HTTP(s)/FTP
  - YouTube audio & video
  - Bittorrent

## Install

### Required software

To get the full benefit, you will need:
  - [wget](https://www.gnu.org/software/wget/)
  - [deluge](https://deluge-torrent.org/) and `deluge-console`
  - [yt-dlp](https://github.com/yt-dlp/yt-dlp)

### Rails things

  - `bundle install`
  - `overmind start` or similar to run the `Procfile`
  - copy `.env.example` to `.env` and fill in the bits
goo