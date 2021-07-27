class RelationshipsController < ApplicationController

  def create
    pharmacist = Pharmacist.find(params[:pharmacist_id])
    @relationship = current_student.relationships.new(pharmacist_id: pharmacist.id, student_id: current_student.id)
    if @relationship.save
      redirect_to student_path(current_student)
    else
      flash[:error] = @relationship.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    student = Student.find(params[:student_id])
    @relationship = Relationship.find_by(pharmacist_id: current_pharmacist.id, student_id: student.id)
    if @relationship.update(params.permit(:allow))
      flash[:notice] = "トークを承認しました"
    else
      flash[:error] = @relationship.errors.full_messages
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    pharmacist = Pharmacist.find(params[:pharmacist_id])
    relationship = Relationship.find_by(pharmacist_id: pharmacist.id, student_id: current_student.id)
    relationship.destroy
    redirect_back(fallback_location: root_path)
  end

end
