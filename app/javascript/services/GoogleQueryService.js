
import { QueryTypes } from "../models/QueryTypes"
import { Blacklists } from "../models/Blacklists"

export class GoogleQueryService {
  constructor (search) {
    this.search = search
    this.server = 'https://www.google.com/'
    this.path = 'search'
  }

  get url () {
    return `${this.server}${this.path}?q=${encodeURIComponent(this._build())}`
  }

  get readableUrl () {
    return this._build()
  }

  _build () {
    let query = ''

    if (this.search.alternative) {
      query = '"parent directory" '
    } else {
      query = 'intitle:"index.of" '
    }

    if (this.search.quoted) {
      query += ` "${this.search.query}" `
    } else {
      query += this.search.query
    }

    query += ' -html -htm -php -asp -jsp '
    query += this._extensions()
    query += this._blacklist()

    return query
  }

  _extensions () {
    return `(${QueryTypes[this.search.queryType].join('|')})`
  }

  _blacklist () {
    return ' ' + Blacklists.map((item) => `-${item}`).join(' ')
  }
}
