class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show

  end

  # GET /tasks/new
  def new
    @project= Project.find_by_id(params[:project_id])
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit    
    @task = Task.find_by_id(params[:id])
    @project= @task.project
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @project= Project.find_by_id(params[:project_id])
    @task = @project.tasks.build(task_params)
    @status= @task.save
    @tasks= @project.tasks  
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    @status= @task.update(task_params)
    @project= @task.project
    @tasks= @project.tasks
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @project= @task.project
    @task.destroy
    respond_to do |format|
      format.html { redirect_to project_path(@project), notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :due_date, :project_id)
    end
end
