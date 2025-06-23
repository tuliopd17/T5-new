class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :isbn
      t.date :publication_date
      t.integer :pages
      t.text :description
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
