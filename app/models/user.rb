class User < ActiveRecord::Base
	has_many :posts
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed
	has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower	

	def full_name 
		fname+ " " +lname
	end 

	def following?(other_user)
		if relationships.find_by(followed_id: User.find(other_user).id)
			true
		else
			 false
		end
	end

	def follow!(other_user)
		relationships.create!(followed_id: User.find(other_user).id)
	end

	def unfollow!(other_user)
		relationships.find_by(followed_id: User.find(other_user).id).destroy!
	end


	attr_accessor :password
	before_save :encrypt_password

	validates_confirmation_of :password
	validates_presence_of :password, :on => :create
	validates_presence_of :email
	validates_uniqueness_of :email
	validates_uniqueness_of :username

	def encrypt_password
		if password.present?
			self.password_salt = BCrypt::Engine.generate_salt
			self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
		end 
	end

	def self.authenticate(username, password)
		user = User.find_by_username(username)
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else 
			nil 
		end
	end 

	#mount_uploader :image, ImageUploader

	scoped_search :on => [:fname, :lname, :username]

end