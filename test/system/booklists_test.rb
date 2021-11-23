require "application_system_test_case"

class BooklistsTest < ApplicationSystemTestCase
  setup do
    @booklist = booklists(:one)
  end

  test "visiting the index" do
    visit booklists_url
    assert_selector "h1", text: "Booklists"
  end

  test "creating a Booklist" do
    visit booklists_url
    click_on "New Booklist"

    fill_in "Book", with: @booklist.book_id
    fill_in "User", with: @booklist.user_id
    click_on "Create Booklist"

    assert_text "Booklist was successfully created"
    click_on "Back"
  end

  test "updating a Booklist" do
    visit booklists_url
    click_on "Edit", match: :first

    fill_in "Book", with: @booklist.book_id
    fill_in "User", with: @booklist.user_id
    click_on "Update Booklist"

    assert_text "Booklist was successfully updated"
    click_on "Back"
  end

  test "destroying a Booklist" do
    visit booklists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Booklist was successfully destroyed"
  end
end
