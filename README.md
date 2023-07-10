# OD Server

Rails 7 based download server.

Makes use of basic open source tools to download data from various sources:
  - Standard HTTP(s)/FTP
  - Google Drive
  - YouTube audio & video
  - Bittorrent

## Install

### Required software

To get the full benefit, you will need:
  - [wget](https://www.gnu.org/software/wget/)
  - [gdl](https://github.com/Akianonymus/gdrive-downloader) (gdrive-downloader)
  - [deluge](https://deluge-torrent.org/) and `deluge-console`
  - [youtube-dl](https://youtube-dl.org/)

### Rails things

  - `bundle install`
  - `overmind start` or similar to run the `Procfile`
  - copy `.env.example` to `.env` and fill in the bits
  - create a user with the rails console (see `db/seeds.rb` for an example)
