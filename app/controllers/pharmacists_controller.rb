class PharmacistsController < ApplicationController
  def show
    @pharmacist_profile = current_pharmacist.pharmacist_profile
    if current_pharmacist.students
      @students = current_pharmacist.students
      if current_pharmacist.relationships.find_by(allow: true)
        @approved_students = @students.joins(:relationships).where(relationships: { allow: true })
      end
      if current_pharmacist.relationships.find_by(allow: false)
        @not_approved_students = @students.joins(:relationships).where(relationships: { allow: false })
      end
    end
  end
end
