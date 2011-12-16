class CreateTiezis < ActiveRecord::Migration
  def change
    create_table :tiezis do |t|
      t.string :link
      t.string :url
      t.string :title

      t.timestamps
    end
  end
end
