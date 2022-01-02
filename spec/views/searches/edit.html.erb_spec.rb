require 'rails_helper'

RSpec.describe "searches/edit", type: :view do
  before(:each) do
    @search = assign(:search, Search.create!(
      user: nil,
      query: "MyString",
      query_type: "MyString",
      alternative: false,
      quoted: false,
      incognito: false
    ))
  end

  it "renders the edit search form" do
    render

    assert_select "form[action=?][method=?]", search_path(@search), "post" do

      assert_select "input[name=?]", "search[user_id]"

      assert_select "input[name=?]", "search[query]"

      assert_select "input[name=?]", "search[query_type]"

      assert_select "input[name=?]", "search[alternative]"

      assert_select "input[name=?]", "search[quoted]"

      assert_select "input[name=?]", "search[incognito]"
    end
  end
end
