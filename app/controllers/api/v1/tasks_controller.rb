class Api::V1::TasksController < ActionController::API

  def index
    @tasks = Task.all
    render json: @tasks, status: 200
  end

  def show
    @task = Task.find(params[:id])
    render status: 200, json: @task
  rescue ActiveRecord::RecordNotFound
    render status:404, json: {}
  end

  def create
    @task = Task.create(task_params)
    render status: 201, json: @task
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
