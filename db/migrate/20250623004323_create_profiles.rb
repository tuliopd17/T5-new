class CreateProfiles < ActiveRecord::Migration[7.2]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :bio
      t.string :avatar_url
      t.string :phone
      t.text :address

      t.timestamps
    end
  end
end
