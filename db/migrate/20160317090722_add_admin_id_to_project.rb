class AddAdminIdToProject < ActiveRecord::Migration
  def change
  	add_reference :projects, :admin, references: :users
  end
end
