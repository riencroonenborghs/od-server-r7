import { Controller } from "@hotwired/stimulus"
import { Search } from "../models/Search"
import { SearchService } from "../services/SearchService"

export default class extends Controller {
  static targets = [ "query", "queryType", "alternative", "quoted", "url" ];

  searchClicked (event) {
    const data = JSON.parse(this.data.get('search'));
    const search = Object.assign(
      new Search(), 
      { 
        query: data.query,
        queryType: data.query_type,
        alternative: data.alternative,
        quoted: data.quoted
      }
    );

    const service = new SearchService(search);
    service.startSearch();
  }
}
