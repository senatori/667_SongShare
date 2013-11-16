class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.date :release_date
      t.string :genre
      t.string :credits
      t.string :album_artwork_url
      t.references :artist, index: true

      t.timestamps
    end
  end
end
