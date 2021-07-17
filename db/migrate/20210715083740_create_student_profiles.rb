class CreateStudentProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :student_profiles do |t|
      t.string :name, null:false
      t.string :image
      t.string :university, null:false
      t.string :year, null:false
      t.text :introduction, null:false
      t.references :student, null: false, index: { unique: true }, foreign_key: true

      t.timestamps
    end
  end
end
