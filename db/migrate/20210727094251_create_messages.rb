class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.references :room, null: false, foreign_key: true
      t.boolean :is_pharmacist, null: false, default: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
