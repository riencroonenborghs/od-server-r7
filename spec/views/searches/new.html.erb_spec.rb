require 'rails_helper'

RSpec.describe "searches/new", type: :view do
  before(:each) do
    assign(:search, Search.new(
      user: nil,
      query: "MyString",
      query_type: "MyString",
      alternative: false,
      quoted: false,
      incognito: false
    ))
  end

  it "renders new search form" do
    render

    assert_select "form[action=?][method=?]", searches_path, "post" do

      assert_select "input[name=?]", "search[user_id]"

      assert_select "input[name=?]", "search[query]"

      assert_select "input[name=?]", "search[query_type]"

      assert_select "input[name=?]", "search[alternative]"

      assert_select "input[name=?]", "search[quoted]"

      assert_select "input[name=?]", "search[incognito]"
    end
  end
end
