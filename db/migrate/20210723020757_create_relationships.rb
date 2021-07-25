class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :pharmacist, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.boolean :allow, null: false, default: false

      t.timestamps
    end
    add_index :relationships, [:pharmacist_id, :student_id], unique: true
  end
end
