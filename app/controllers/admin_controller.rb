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
          render :layout => false
  end

  def index
    render :layout => false
  end

  def time_table
    render :layout => false
  end

  def research
    render :layout => false
  end
end