export class Search {
  get id () { return this._id }
  set id (id) { this._id = id }

  get query () { return this._query }
  set query (query) { this._query = query }

  get queryType () { return this._queryType }
  set queryType (queryType) { this._queryType = queryType }

  get alternative () { return this._alternative }
  set alternative (alternative) { this._alternative = alternative }

  get quoted () { return this._quoted }
  set quoted (quoted) { this._quoted = quoted }

  get incognito () { return this._incognito }
  set incognito (incognito) { this._incognito = incognito }

  // enum query_type: { movies: 0, tpb: 1, leet: 2, youtube: 3, music: 4, books: 5, mac_software: 6, general: 7 }
  get tpb () {
    return this.queryType == 1
  }

  get leet () {
    return this.queryType == 2
  }

  get youtube () {
    return this.queryType == 3
  }

  get google () {
    return !this.tpb && !this.leet && !this.youtube
  }
}
