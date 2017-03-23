class AddSearchUrlToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :search_url, :string
  end
end
