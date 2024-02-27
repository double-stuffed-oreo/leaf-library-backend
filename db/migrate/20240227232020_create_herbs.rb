class CreateHerbs < ActiveRecord::Migration[7.1]
  def change
    create_table :herbs do |t|
      t.string :name
      t.string :scientific_name
      t.text :summary
      t.text :benefit
      t.text :warning
      t.text :image
      t.integer :user_id

      t.timestamps
    end
  end
end
