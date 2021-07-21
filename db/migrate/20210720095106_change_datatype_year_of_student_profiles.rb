class ChangeDatatypeYearOfStudentProfiles < ActiveRecord::Migration[6.1]
  def change
    change_column :student_profiles, :year, :integer
  end
end
