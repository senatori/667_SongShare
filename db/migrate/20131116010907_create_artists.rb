class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string :name
      t.string :description
      t.string :email
      t.string :password_digest
      t.string :photo_url

      t.timestamps
    end
  end
end
