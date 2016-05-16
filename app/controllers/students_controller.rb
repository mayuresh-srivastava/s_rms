class StudentsController < ApplicationController
    def new
    @student = Student.new
  #  @students = Student.find[:all]
    end
    
    def create
    @student = Student.new(student_params) 
    if @student.save
      redirect_to new_student_path
     end 
    end 
    
    private
     def student_params
         params.require(:student).permit(:first_name, :last_name)
     end     
end
