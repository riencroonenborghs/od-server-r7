require 'rails_helper'

RSpec.describe "searches/index", type: :view do
  before(:each) do
    assign(:searches, [
      Search.create!(
        user: nil,
        query: "Query",
        query_type: "Query Type",
        alternative: false,
        quoted: false,
        incognito: false
      ),
      Search.create!(
        user: nil,
        query: "Query",
        query_type: "Query Type",
        alternative: false,
        quoted: false,
        incognito: false
      )
    ])
  end

  it "renders a list of searches" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Query".to_s, count: 2
    assert_select "tr>td", text: "Query Type".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
  end
end
