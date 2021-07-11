class CreatePharmacistProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :pharmacist_profiles do |t|
      t.string :name
      t.string :image
      t.string :work_place, null: false
      t.string :work_place_type, null: false
      t.integer :work_location, null: false, default: 0
      t.string :university, null: false
      t.text :introduction, null: false
      t.references :pharmacist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
