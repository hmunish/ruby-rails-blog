class AddDefaultPhotoToUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :photo, "https://unsplash.com/photos/man-person-standing-between-tall-trees-F_-0BxGuVvo"
  end
end
