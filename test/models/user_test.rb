require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  should 'have a username with at least 2 characters' do
	user = Fabricate.build(:user)
	user.username = "a"*1
	assert !user.valid?
  end
  
  should 'have a username no more than 15 characters' do
	  user = Fabricate.build(:user)
	  user.username = "a"*16
	  assert !user.valid?
  end

  should 'have a password salt' do
	  user = Fabricate.build(:user)
	  user.password_salt = nil
	  assert !user.valid?
  end

  should 'have a password' do
	  user = Fabricate.build(:user)
	  user.password = "foo" 
	  assert_equal "foo", user.password
  end

  should 'have a password with 8 or more characters' do
	  user = Fabricate.build(:user, :password => "aaaaaa1")
	  assert !user.valid?
  end

  should 'have a password hash different from password' do
  end

  should 'have a unique email address' do
	  Fabricate(:user, :email => "foo@bar.com")
	  user = Fabricate.build(:user, :email => "foo@bar.com")
	  assert user.invalid?
  end

  should 'have a unique username' do
	  user1 = Fabricate.build(:user)
	  user1.username = "foo"
	  user2 = Fabricate.build(:user)
	  user2.username = "foo"
	  assert user2.invalid?
  end
end
