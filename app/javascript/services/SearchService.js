import { GoogleQueryService } from './GoogleQueryService'
import { TpbService } from './TpbService'
import { YoutubeService } from './YoutubeService'

export class SearchService {
  constructor (search) {
    this.search = search
  }

  startSearch () {
    // chrome.windows.create({
    //   url: this.service.url,
    //   incognito: this.search.incognito
    // })
    window.open(this.service.url, '_blank')
  }

  get service () {
    if (this.search.tpb) return new TpbService(this.search)
    else if (this.search.youtube) return new YoutubeService(this.search)
    else return new GoogleQueryService(this.search)
  }
}
