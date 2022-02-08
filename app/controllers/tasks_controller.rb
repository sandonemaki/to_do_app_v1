class TasksController < ApplicationController
  def index
    tasks = Task.where(done_flag: 0).order(created_at: :desc)
    render("index", locals: {tasks: tasks})
  end

  def fin_index
    tasks = Task.where(done_flag: 1).order(created_at: :desc)
    render("fin_index", locals: {tasks: tasks})
  end

  def new
    task = Task.new
    render("new", locals: {task: task})
  end

  def create
    task = Task.new(
      content: params[:content],
      done_flag: 0,
      image_status: "undone.png"
    )
    if task.save
      redirect_to("/", locals: {task: task})
    else
      p task.errors[:content]
      render("new", locals: {task: task})
    end
  end

  def edit
    task = Task.find_by(id: params[:id])
    render("edit", locals: {task: task})
  end

  def update
    task = Task.find_by(id: params[:id])
    task.content = params[:content]
    if task.save
      flash[:notice]="やることを編集しました"
      redirect_to("/", locals: {task: task})
    else
      render("edit", locals: {task: task})
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])
    task.destroy
    flash[:notice]="タスクを削除しました"
    redirect_to("/", locals: {task: task})
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
