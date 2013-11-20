class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :detail_url
      t.string :unique_code
      t.string :title
      t.string :phone_num
      t.string :address
      t.string :street
      t.string :locality
      t.string :region
      t.string :postal_code

      t.timestamps
    end
  end
end
