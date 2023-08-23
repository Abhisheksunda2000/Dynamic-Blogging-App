class AddMinutesToReadToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :minutes_to_read, :int
  end
end
