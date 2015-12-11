class CreateDownloads < ActiveRecord::Migration
  def change
    create_table :downloads do |t|
      t.string :title
      t.string :filename
      t.string :comment

      t.timestamps null: false
    end
  end
end
