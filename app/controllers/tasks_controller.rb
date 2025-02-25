class TasksController < ApplicationController
  before_action :require_login, only: [:create, :destroy]

  def index
    @tasks = Task.all
  end

  def create
    @task = Task.new
    @task["description"] = params["description"]
    if @task.save
      flash[:notice] = "Task added successfully."
    else
      flash[:alert] = "Error adding task."
    end
    redirect_to "/tasks"
  end

  def destroy
    @task = Task.find_by(id: params["id"])
    if @task
      @task.destroy
      flash[:notice] = "Task completed!"
    else
      flash[:alert] = "Task not found."
    end
    redirect_to "/tasks"
  end

  private

  def require_login
    unless session["user_id"]
      flash[:alert] = "You must be logged in to create or delete tasks."
      redirect_to "/login"
    end
  end
end
