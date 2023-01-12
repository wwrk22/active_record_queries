require "application_system_test_case"

class ReviewsTest < ApplicationSystemTestCase
  setup do
    @review = reviews(:one)
  end

  test "visiting the index" do
    visit reviews_url
    assert_selector "h1", text: "Reviews"
  end

  test "should create review" do
    visit reviews_url
    click_on "New review"

    fill_in "Body", with: @review.body
    fill_in "Book", with: @review.book_id
    fill_in "Customer", with: @review.customer_id
    fill_in "Rating", with: @review.rating
    fill_in "State", with: @review.state
    fill_in "Title", with: @review.title
    click_on "Create Review"

    assert_text "Review was successfully created"
    click_on "Back"
  end

  test "should update Review" do
    visit review_url(@review)
    click_on "Edit this review", match: :first

    fill_in "Body", with: @review.body
    fill_in "Book", with: @review.book_id
    fill_in "Customer", with: @review.customer_id
    fill_in "Rating", with: @review.rating
    fill_in "State", with: @review.state
    fill_in "Title", with: @review.title
    click_on "Update Review"

    assert_text "Review was successfully updated"
    click_on "Back"
  end

  test "should destroy Review" do
    visit review_url(@review)
    click_on "Destroy this review", match: :first

    assert_text "Review was successfully destroyed"
  end
end
