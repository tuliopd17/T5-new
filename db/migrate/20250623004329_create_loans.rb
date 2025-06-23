class CreateLoans < ActiveRecord::Migration[7.2]
  def change
    create_table :loans do |t|
      t.references :user, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.date :loan_date
      t.date :return_date
      t.boolean :returned
      t.string :status

      t.timestamps
    end
  end
end
