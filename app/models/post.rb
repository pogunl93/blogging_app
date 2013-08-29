class Post < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :post_description, :message => 'Please enter a post description'
	validates_presence_of :post_name
	validates_presence_of :post_text
end
