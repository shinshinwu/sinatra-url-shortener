class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :original_address
      t.string :slug
      t.integer :click_count, default: 0
      t.belongs_to :user

      t.timestamps
    end
  end
end
