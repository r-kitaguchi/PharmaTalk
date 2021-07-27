class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.references :pharmacist, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true

      t.timestamps
    end
    add_index :rooms, [:pharmacist_id, :student_id], unique: true
  end
end
