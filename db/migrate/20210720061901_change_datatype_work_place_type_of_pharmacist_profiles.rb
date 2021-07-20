class ChangeDatatypeWorkPlaceTypeOfPharmacistProfiles < ActiveRecord::Migration[6.1]
  def change
    change_column :pharmacist_profiles, :work_place_type, :integer
  end
end
