require 'bcrypt'
class User < ApplicationRecord
	EMAIL_REGEX = /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

	validates :username, :uniqueness => true, :length => 2..15, :format => /\A[^@]+\z/
	validates :email, :uniqueness => true, :format => EMAIL_REGEX
	validates :first_name, :length => 1..15
	validates :last_name, :length => 1..15
	validates :password, :length => {:minimum => 8}, :format => /\d/, :exclusion => ["12345678"], :if => :password_validatible?
	
	attr_accessor :password

	before_save :encrypt_password

	private

	def password_validatible?
		password.present? || new_record?
        end

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end
	end
end
