class ArtImage < ApplicationRecord
	validates :image_url, uniqueness: true
	validates :art_id_number, uniqueness: true
	validates :art_title, uniqueness: true
	# validates :art_description, uniqueness: true
end
