class TasksController < ApplicationController
  def index
    @tasks = Task.where(done_flag: 0).order(created_at: :desc)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(
      content: params[:content],
      done_flag: 0,
      status_image: "undone.png"
    )
    if @task.save
      redirect_to("/tasks/index")
    else
      render("tasks/new")
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
  end

  def update
    @task = Task.find_by(id: params[:id])
    @task.content = params[:content]
    if @task.save
      flash[:notice]="やることを編集しました"
      redirect_to("/tasks/index")
    else
      render("tasks/edit")
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @task.destroy
    flash[:notice]="タスクを削除しました"
    redirect_to("/tasks/index")
  end

  def done
    task = Task.find_by(id: params[:id])
    task.done_flag = 1
    if task.save
      # @tasks = Task.where(done_flag: 0)
      redirect_to("/tasks/index")
    end
  end

  def undone
    @task = Task.find_by(params[:id])
    @undone_task = UndoneTask.new(conatent: @task.content)
    @undone_task.save
    @task.delete
    render("taskes/fin_index")
  end
end
