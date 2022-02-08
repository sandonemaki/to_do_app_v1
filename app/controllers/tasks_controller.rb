class TasksController < ApplicationController
  def index
    @tasks = Task.where(done_flag: 0).order(created_at: :desc)
    render("index")
  end

  def fin_index
    @tasks = Task.where(done_flag: 1).order(created_at: :desc)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(
      content: params[:content],
      done_flag: 0,
      image_status: "undone.png"
    )
    if @task.save
      redirect_to("/")
    else
      p @task.errors[:content]
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
      redirect_to("/")
    else
      render("tasks/edit")
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @task.destroy
    flash[:notice]="タスクを削除しました"
    redirect_to("/")
  end

  def done
    task = Task.find_by(id: params[:id])
    task.done_flag = 1
    task.image_status = "done.png"
    if task.save
      # @tasks = Task.where(done_flag: 0)
      redirect_to("/")
    end
  end

  def undone
    task = Task.find_by(id: params[:id])
    task.done_flag = 0
    task.image_status = "undone.png"
    if task.save!
      puts "保存"
      redirect_to("/tasks/fin_index")
    end
  end
end
