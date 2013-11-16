class CreateFollowedArtists < ActiveRecord::Migration
  def change
    create_table :followed_artists do |t|
      t.references :fan, index: true
      t.references :artist, index: true

      t.timestamps
    end
  end
end
