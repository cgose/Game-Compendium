class AddEmailtoUser < ActiveRecord::Migration[5.0]
  def change
	  add_column :user, :email, string
  end
end
