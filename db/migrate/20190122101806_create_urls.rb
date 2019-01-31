class CreateUrls < ActiveRecord::Migration[5.2]
  def change
    create_table :urls do |t|
      t.string :short_url
      t.string :original_url

      t.timestamps
    end
  end
end
