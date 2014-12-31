class AdminController < ApplicationController
  def home
    render :layout => "application"
  end

  def page_full_width
     render :layout => false
  end
  
  def page_other
     render :layout => false
  end

  def dashboard
   render :layout => false
  end

  def settings
          @settings = school_setting
          render :layout => false
  end

  def index
    render :layout => false
  end

  def time_table
    @subjects = Course.find_by_sql("SELECT course_id, name FROM course").collect{|c| [c.course_id, c.name]}.to_json
    render :layout => false
  end

  def research
    render :layout => false
  end

  def add_property
      g = GlobalProperty.find_by_property("#{params[:name]}")
      if g.blank?
        GlobalProperty.create(:property => params[:name],
                                  :value => params[:value])
      else
        g.value = params[:value]
        g.save
      end
        render :text => g.to_json
  end
end
