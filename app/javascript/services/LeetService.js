export class LeetService {
  constructor (search) {
    this.search = search
    this.SERVER = 'https://1337x.to/'
    this.PATH = 'search/'
  }

  get url () {
    return `${this.SERVER}${this.PATH}${encodeURIComponent(this.search.query)}/1/`
  }

  get readableUrl () {
    return `Search 1337 for "${this.search.query}"`
  }
}
