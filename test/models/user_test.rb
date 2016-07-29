require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  should "validate" do
	  user = Fabricate.build(:uers)
	  assert user.invalid?
  end
  should "require an email address" do
	  user = Fabricate.build(:user)
	  user.email = nil
	  assert user.invalid?
  end
  should "require a unique email address" do
	  user1 = Fabricatre.build(:user)
	  user2 = Fabricate.build(:user)
	  user2.email = user1.email

	  assert user2.invalid?
  end
  should "require a properly formatted email" do
	  user = Fabricate.build(:user)
	  addresses = ["foo", "foo@bar", "foo.com"]

	  addresses.each do |address|
		  user.email = address
		  assert user.invalid?, "#{address} should not be valid"
	  end
  end
  should "require a unique screen name" do
	  user1 = Fabricate.build(:user, :user_name => "john")
	  user2 = Fabricate.build(:user, :user_name => "john")
	  user2.user_name = user1.user_name
	  assert user2.invalid?
  end
  should "require a user name no more than 15 characters long" do
	  user = Fabricate.build(:user, :user_name => "a" * 16)
	  assert user.invalid?
  end
  should "require a user name greater than 2 characters" do
	  user = Fabricate.build(:user, :user_name => "a" * 2)
	  assert user.invalid?
  should "requre a first name greater than 1 characters" do
	  user = Fabricate.build(:user, :first_name => "a")
	  assert user.invalid?
  end 
  should "require a last name greater than 1 character" do
	  user = Fabricate.build(:user, :last_name => "a")
	  assert user.invalid?
  end
  should "have a password" do
	  user = Fabricate.build(:user)
	  user.password = "foo"
	  assert_equal "foo", user.password
  end
  should "have a password at least 8 characters long" do
	  user = Fabricate.build(:user, :password => "a")
	  assert user.invalid?
  end
  should "have a password with at least 1 number" do
	  user = Fabricate.build(:user, :password => "a" * 8)
	  assert user.invalid?
  end
  should "have a password with at least 1 special character" do
	  user = Fabricate.build(:user, :password =>"1a" * 4)
	  assert user.invalid?
  end
  should "not validate password if the password is blank" do
	  user = Fabricate.build(:user, :password => nil)
	  user.user_name = "test"
	  user.first_name = "John"
	  user.last_name = "Doe"
	  user.email = "test@test.com"
	  user.password = nil
  end
end
