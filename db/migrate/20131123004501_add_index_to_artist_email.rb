class AddIndexToArtistEmail < ActiveRecord::Migration
  def change
    add_index :artists, :email, unique: true
  end
end
