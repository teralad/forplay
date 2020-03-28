require "application_system_test_case"

class PostFollowersTest < ApplicationSystemTestCase
  setup do
    @post_follower = post_followers(:one)
  end

  test "visiting the index" do
    visit post_followers_url
    assert_selector "h1", text: "Post Followers"
  end

  test "creating a Post follower" do
    visit post_followers_url
    click_on "New Post Follower"

    click_on "Create Post follower"

    assert_text "Post follower was successfully created"
    click_on "Back"
  end

  test "updating a Post follower" do
    visit post_followers_url
    click_on "Edit", match: :first

    click_on "Update Post follower"

    assert_text "Post follower was successfully updated"
    click_on "Back"
  end

  test "destroying a Post follower" do
    visit post_followers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Post follower was successfully destroyed"
  end
end
