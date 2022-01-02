export class RarbgService {
  constructor (search) {
    this.search = search
    this.SERVER = 'http://rarbg.to/'
    this.PATH = 'torrents.php?search='
  }

  get url () {
    return `${this.SERVER}${this.PATH}${encodeURIComponent(this.search.query)}`
  }

  get readableUrl () {
    return `Search RARBG for "${this.search.query}"`
  }
}
