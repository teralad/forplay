require 'test_helper'

class PostFollowersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post_follower = post_followers(:one)
  end

  test "should get index" do
    get post_followers_url
    assert_response :success
  end

  test "should get new" do
    get new_post_follower_url
    assert_response :success
  end

  test "should create post_follower" do
    assert_difference('PostFollower.count') do
      post post_followers_url, params: { post_follower: {  } }
    end

    assert_redirected_to post_follower_url(PostFollower.last)
  end

  test "should show post_follower" do
    get post_follower_url(@post_follower)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_follower_url(@post_follower)
    assert_response :success
  end

  test "should update post_follower" do
    patch post_follower_url(@post_follower), params: { post_follower: {  } }
    assert_redirected_to post_follower_url(@post_follower)
  end

  test "should destroy post_follower" do
    assert_difference('PostFollower.count', -1) do
      delete post_follower_url(@post_follower)
    end

    assert_redirected_to post_followers_url
  end
end
