class CourseController < ApplicationController
  def index
    @class_rooms = ClassRoom.find(:all).map(&:name)
    @class_room_courses = []

    class_rooms = ClassRoom.find(:all)
    (class_rooms || []).each do |class_room|
      total_courses = class_room.class_room_courses.count
      @class_room_courses << total_courses
    end
    
    render :layout => false
  end

  def add_course
    render :layout => false
  end

  def edit_course
    @courses = Course.all
    render :layout => false
  end

  def remove_course
    @courses = Course.all
    render :layout => false
  end

  def delete_courses
    if (params[:mode] == 'single_entry')
      course = Course.find(params[:course_id])
      course.delete
      render :text => "true" and return
    end
    
    course_ids = params[:course_ids].split(",")
    (course_ids || []).each do |course_id|
     course = Course.find(course_id)
     course.delete
    end
    render :text => "true" and return
  end
  
  def view_courses
    @courses = Course.all
    render :layout => false
  end

  def edit_me
    @course = Course.find(params[:course_id])
    if request.method == :post
      if (@course.update_attributes({
          :name => params[:course_name]
        }))
        flash[:notice] = "You have successfully edited the details"
        redirect_to :action => "edit_course" and return
      else
        flash[:error] = "Process aborted. Check for errors and try again"
        redirect_to :action => "edit_course" and return
      end
    end
    render :layout => false
  end
  
  def create
    if (Course.create({
        :name => params[:course_name]
      }))
      flash[:notice] = "Operation successful"
      redirect_to :controller => "course", :action => "add_course"
    else
      flash[:error] = "Unable to save. Check for errors and try again"
      render :controller => "course", :action => "add_course"
    end
  end
end
