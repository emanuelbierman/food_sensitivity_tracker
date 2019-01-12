class AddCommentsToDays < ActiveRecord::Migration[5.2]
  def change
    add_column :days, :comments, :string
  end
end
