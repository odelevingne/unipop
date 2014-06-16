class Listing < ActiveRecord::Base
	
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  belongs_to :seller, class_name: 'User'
  has_and_belongs_to_many :buyers, class_name: 'User', association_foreign_key: 'buyer_id', join_table: 'buyers_listings'
  has_and_belongs_to_many :hashtags
  has_one :chatroom
  has_many :image_containers

  def self.search(query)
    if query 
      tag = Hashtag.find_by(name: query)
      tag ? tag.listings.order(created_at: :desc) : []
    else
      self.all
    end
  end

  def hashtag_names
  	''
  end

	def hashtag_names=(hashtag_input)
		return if hashtag_input.blank?
		formatted_hashtags = hashtag_input.downcase.split(/[\s,|.]+/).uniq
 		formatted_hashtags.each do |one_hashtag|
			hashtag = Hashtag.find_or_create_by(name: one_hashtag)
			hashtags << hashtag
		end
	end
end



# def self.search(search_input)
# 	splitted_search_terms = search_input.split(', ')
# 	where("hashtags.each{|hashtag| hashtag.name = ?}", params[:search])
# end 

