class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.references :message, null: false, foreign_key: true
      t.references :pharmacist, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.boolean :is_pharmacist, null: false, default: false

      t.timestamps
    end
  end
end
