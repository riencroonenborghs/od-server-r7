export class TpbService {
  constructor (search) {
    this.search = search
    this.SERVER = 'https://thepiratebay.org/'
    this.PATH = 'search.php'
  }

  get url () {
    return `${this.SERVER}${this.PATH}?q=${encodeURIComponent(this.search.query)}&all=on&search=Pirate+Search&page=0&orderby=`
  }

  get readableUrl () {
    return `Search TPB for "${this.search.query}"`
  }
}
