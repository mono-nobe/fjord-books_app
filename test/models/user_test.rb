# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # following?のテスト
  test 'followfing?_正常系_AliceがBobをフォローしている' do
    alice = users(:alice)
    bob = users(:bob)

    alice.follow(bob)

    assert alice.following?(bob)
  end

  test 'followfing?_正常系_AliceがBobをフォローしていない' do
    alice = users(:alice)
    bob = users(:bob)

    assert_not alice.following?(bob)
  end

  # followed_by?のテスト
  test 'followed_by?_正常系_AliceがBobからフォローされている' do
    alice = users(:alice)
    bob = users(:bob)

    bob.follow(alice)

    assert alice.followed_by?(bob)
  end

  test 'followed_by?_正常系_AliceがBobからフォローされていない' do
    alice = users(:alice)
    bob = users(:bob)

    assert_not alice.followed_by?(bob)
  end

  # followのテスト
  test 'follow_正常系_AliceがBobをフォローしている' do
    alice = users(:alice)
    bob = users(:bob)

    first_alice_and_bob_relation = alice.follow(bob)
    second_alice_and_bob_relation = alice.follow(bob)

    assert_equal first_alice_and_bob_relation, second_alice_and_bob_relation
  end

  test 'follow_正常系_AliceがBobをフォローしていない' do
    alice = users(:alice)
    bob = users(:bob)

    alice_and_bob_relation = alice.follow(bob)

    assert_equal alice_and_bob_relation.following_id, bob.id
    assert_equal alice_and_bob_relation.follower_id, alice.id
  end

  # unfollowのテスト
  test 'unfollow_正常系_AliceがBobをフォローしている' do
    alice = users(:alice)
    bob = users(:bob)

    # AliceがBobをフォローしていることを確認
    alice.follow(bob)
    assert alice.following?(bob)

    alice_and_bob_relation = alice.unfollow(bob)

    assert_equal alice_and_bob_relation.following_id, bob.id
    assert_equal alice_and_bob_relation.follower_id, alice.id
    assert_not Relationship.find_by(id: alice_and_bob_relation.id)
  end

  test 'unfollow_正常系_AliceがBobをフォローしていない' do
    alice = users(:alice)
    bob = users(:bob)

    assert_not alice.unfollow(bob)
  end

  # name_or_emailのテスト
  test 'name_or_email_正常系_名前がない' do
    user = User.new(email: 'hoge@example.com', name: '')

    assert_equal 'hoge@example.com', user.name_or_email
  end

  test 'name_or_email_正常系_名前がある' do
    user = User.new(email: 'hoge@example.com', name: 'Alice')

    assert_equal 'Alice', user.name_or_email
  end
end
