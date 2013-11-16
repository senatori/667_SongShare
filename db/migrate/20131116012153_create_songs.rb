class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.string :featured_artists
      t.boolean :is_downloadable
      t.integer :track_number
      t.string :source_url
      t.references :album, index: true
      t.references :artist, index: true

      t.timestamps
    end
  end
end
