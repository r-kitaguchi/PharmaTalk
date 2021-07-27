class PharmacistsController < ApplicationController
  def show
    @pharmacist_profile = current_pharmacist.pharmacist_profile
    if current_pharmacist.students
      if current_pharmacist.relationships.find_by(allow: true)
        @approved_students = Student.eager_load(:relationships, :student_profile).where(relationships: { pharmacist_id: current_pharmacist.id, allow: true })
      end
      if current_pharmacist.relationships.find_by(allow: false)
        @not_approved_students = Student.eager_load(:relationships, :student_profile).where(relationships: { pharmacist_id: current_pharmacist.id, allow: false })
      end
    end
  end
end
