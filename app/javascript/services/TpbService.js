export class TpbService {
  constructor (search) {
    this.search = search
    this.SERVER = 'https://tpirbay.site/'
    this.PATH = 'search/'
  }

  get url () {
    return `${this.SERVER}${this.PATH}${encodeURIComponent(this.search.query)}`
  }

  get readableUrl () {
    return `Search TPB for "${this.search.query}"`
  }
}
