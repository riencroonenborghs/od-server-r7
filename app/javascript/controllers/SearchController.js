import { Controller } from "@hotwired/stimulus"
import { Search } from "../models/Search"
import { SearchService } from "../services/SearchService"

export default class extends Controller {
  // static targets = [ "query", "queryType", "alternative", "quoted", "incognito", "url" ];
  static targets = [ "query", "queryType", "alternative", "quoted", "url" ];

  queryChanged () {    
    this.search = this.createSearch();
  }

  queryTypeChanged () {
    this.search = this.createSearch();
  }

  alternativeChanged () {
    this.search = this.createSearch();
  }

  quotedChanged () {
    this.search = this.createSearch();
  }

  incognitoChanged () {
    this.search = this.createSearch();
  }

  createSearch () {
    const search = Object.assign(
      new Search(), 
      { 
        query: this.queryTarget.value,
        queryType: parseInt(this.queryTypeTarget.value),
        alternative: this.alternativeTarget.checked,
        quoted: this.quotedTarget.checked//,
        // incognito: this.incognitoTarget.checked
      }
    );

    if (search.query !== '') {
      const service = new SearchService(search);
      this.urlTarget.innerText = service.service.url;
      this.urlTarget.classList.remove("d-none");
    } else {
      this.urlTarget.classList.add("d-none");
    }
    return search;
  }

  searchClicked () {
    const service = new SearchService(this.search);
    service.startSearch();
  }
}
