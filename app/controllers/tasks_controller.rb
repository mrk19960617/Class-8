class TasksController < ApplicationController
  before_action :require_login

  def index
    @tasks = Task.where(user_id: session["user_id"]) # Show only logged-in user's tasks
  end

  def create
    @task = Task.new
    @task.description = params["description"]
    @task.user_id = session["user_id"] # Assign task to logged-in user

    if @task.save
      flash[:notice] = "Task added successfully."
    else
      flash[:alert] = "Error adding task."
    end
    redirect_to "/tasks"
  end

  def destroy
    @task = Task.find_by(id: params["id"], user_id: session["user_id"]) # Ensure user can only delete their own task

    if @task
      @task.destroy
      flash[:notice] = "Task completed!"
    else
      flash[:alert] = "Task not found or unauthorized."
    end
    redirect_to "/tasks"
  end

  private

  def require_login
    unless session["user_id"]
      flash[:alert] = "You must be logged in to view, create, or delete tasks."
      redirect_to "/login"
    end
  end
end
