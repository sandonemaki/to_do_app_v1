class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: :desc)
  end

  def new

  end

  def create
    @task = Task.new(content: params[:content])
    @task.save
    redirect_to("/tasks/index")
  end
end
