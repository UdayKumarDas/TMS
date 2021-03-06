class ProjectsController < ApplicationController
  layout 'admin_lte_2'
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy,:invite_users,:create_invite_users]

  # GET /projects
  # GET /projects.json
  def index    
    @projects = current_user.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @task= Task.new
    @tasks= @project.tasks
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.admin_id= current_user.id
    respond_to do |format|
      if @project.save
        current_user.projects << @project
        format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def invite_users
    p @users= User.where.not(:id=>@project.users.pluck(:id))
  end

  def create_invite_users
     invite_user= User.find_by_id(params[:user])
     @project.users << invite_user
   p UserMailer.invitation_to_user(@project.user,invite_user,@project).deliver
     redirect_to project_path(@project), notice: "Invitation mail was successfully delivered to #{invite_user.email}" 
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :submission_date,:admin_id,:description,:picture)
    end
end
