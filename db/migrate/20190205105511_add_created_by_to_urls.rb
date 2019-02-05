class AddCreatedByToUrls < ActiveRecord::Migration[5.2]
  def change
    add_column :urls, :created_by, :string
  end
end
