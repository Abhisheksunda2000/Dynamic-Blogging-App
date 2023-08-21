class CreatePostsPlaylistsJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :posts_playlists, id: false do |t|
      t.belongs_to :post
      t.belongs_to :playlist
      end

   add_index :posts_playlists, [:post_id, :playlist_id], unique: true
  end
end
