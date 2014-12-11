class ExaminationController < ApplicationController
  def index
    render :layout => false
  end

  def new_exam_type
    if (request.method == :post)
        if (ExaminationType.create({
          :name => params[:exam_type]
        }))
          flash[:notice] = "You have successfully added exam type"
          redirect_to :action => "new_exam_type" and return
        end
    end

    render :layout => false
  end

  def edit_exam_type
    @exam_types = ExaminationType.all
    render :layout => false
  end

  def edit_me
    @exam_type = ExaminationType.find(params[:exam_type_id])
    
    if (request.method == :post)
        if (@exam_type.update_attributes({
          :name => params[:exam_type]
        }))

          flash[:notice] = "You have successfully edited exam type"
          redirect_to :action => "edit_exam_type" and return
        else
          flash[:error] = "Operation aborted"
          redirect_to :action => "edit_me", :exam_type_id => params[:exam_type_id]
        end
    end

    render :layout => false
  end
  
  def void_exam_type
    @exam_types = ExaminationType.all
    render :layout => false
  end
  
  def assign_exam
    @class_rooms = ClassRoom.all.collect{|c|[c.name, c.id]}
    @exam_types = ExaminationType.all.collect{|e|[e.name, e.id]}
    @courses = Course.all.collect{|c|[c.name, c.id]}
    render :layout => false
  end

  def edit_exam_assignment
    render :layout => false
  end

  def delete_exam_types
    if (params[:mode] == 'single_entry')
      exam_type = ExaminationType.find(params[:exam_type_id])
      exam_type.delete
      render :text => "true" and return
    end

    exam_type_ids = params[:exam_type_ids].split(",")
      (exam_type_ids || []).each do |exam_type_id|
       exam_type = ExaminationType.find(exam_type_id)
       exam_type.delete
    end
    
    render :text => "true" and return
  end
  
end
