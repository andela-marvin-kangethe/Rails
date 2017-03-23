class CreateArtImages < ActiveRecord::Migration[5.0]
  def change
    create_table :art_images do |t|
      t.string :art_title
      t.string :image_url
      t.string :art_description
      t.string :art_maker
      t.string :art_id_number

      t.timestamps
    end
  end
end
