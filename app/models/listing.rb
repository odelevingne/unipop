class Listing < ActiveRecord::Base
	has_attached_file :picture, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  belongs_to :seller, class_name: 'User'
  has_and_belongs_to_many :buyers, class_name: 'User', association_foreign_key: 'buyer_id', join_table: 'buyers_listings'
  has_and_belongs_to_many :hashtags

  def hashtag_names
  	listing_hashtags = []
  	self.hashtags.each do |hashtag|
  		listing_hashtags << hashtag.name
  	end
  	listing_hashtags.join(', ')
  end

	def hashtag_names=(hashtag_input)
		return if hashtag_input.blank?
		formatted_hashtags = hashtag_input.downcase
		self.hashtags.delete_all
		formatted_hashtags.split(/[\s,|.]+/).uniq.each do |one_hashtag|
			hashtag = Hashtag.find_or_create_by(name: one_hashtag)
			hashtags << hashtag
		end
	end

end



# def self.search(search_input)
# 	splitted_search_terms = search_input.split(', ')
# 	where("hashtags.each{|hashtag| hashtag.name = ?}", params[:search])
# end 

