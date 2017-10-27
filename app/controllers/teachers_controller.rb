class TeachersController < ApplicationController

  before_action :set_teacher, only: [:show, :edit, :update, :destroy, :toggle_status]
  #access all: [:show, :index], user: {except: [:destroy]}, root_admin: :all

  def index
    @teachers = Teacher.all.paginate(page: params[:page], per_page: 3)
  end

  def show
  end

  def new
    @teacher = Teacher.new
  end

  def create
    @teacher = Teacher.new(teacher_params)
    if @teacher.save
      flash[:notice] = "#{t(:teacher)} #{t(:created)}"
      redirect_to teachers_path
    else
      render :new
    end
  end

  def edit
  end

   def update
    if @teacher.update(teacher_params)
      flash[:notice] = "#{t(:teacher)} #{t(:updated)}"
      redirect_to teachers_path
    else
      render :edit
    end
  end

  def destroy
    @teacher.destroy
    flash[:notice] = "#{t(:teacher)} #{t(:deleted)}"
    redirect_to teachers_path
  end

  private
    
    def teacher_params
      params.require(:teacher).permit(:name, :biography, :main_image, :thumb_nail )
    end

    def set_teacher
      @teacher = Teacher.friendly.find(params[:id])
    end
end