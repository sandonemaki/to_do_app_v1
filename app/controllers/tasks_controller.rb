class TasksController < ApplicationController
  before_action :task_id_nil?, only: [:edit, :update, :destroy]

  # ActiveRecordを継承したインスタンスオブジェクトをview側で使用しない。
  def index
    # tasks = Task.where(done_flag: 0).order(created_at: :desc) #Task::ActiveRecord_Relatio
    # viewに渡す変数を作成する
    tasks = Task.where(done_flag: 0).order(created_at: :desc).pluck(:id, :image_status, :content, :created_at) #Array
    tasks_view_model = PresenterIndex.new(tasks_ary: tasks)
    render("index", locals: {tasks: tasks_view_model})
  end


  def fin_index
    tasks = Task.where(done_flag: 1).order(created_at: :desc).pluck(:id, :image_status, :content, :created_at) #Array
    tasks_view_model = PresenterIndex.new(tasks_ary: tasks)
    render("fin_index", locals: {tasks: tasks_view_model})
  end

  def new
    task2 = Task.new #Task<ActiveRecord
    task2_content = task2.content #String or nil
    task_view_model = PresenterNew.new(content: task2_content) #PresenterNew
    render("new", locals: {task: task_view_model})
  end

  def create
      task = Task.new( #Task<ActiveRecord
      content: params[:content], #String or NilClass
      done_flag: 0, #NilClass or Integer
      image_status: "undone.png" #NilClass or String
    )
    if task.save
      redirect_to("/")
    else
      # viewに渡す変数を作成する。
      task2_content = task.content #String or nil
      task2_errors = task.errors #Hash
      task_view_model = PresenterCreate.new(content: task2_content, errors: task2_errors) #PresenterCreate
      render("new", locals: {task: task_view_model})
    end
  end

  def edit
    task = Task.find_by(id: params[:id]) #Task<ActiveRecord
    # viewに渡す変数を作成する
    task_id = task.id #Integer
    task_content = task.content #String or nil
    task_errors = task.errors #ActiveModel::Errors
    task_view_model = PresenterEdit.new(content: task_content, errors: task_errors, id: task_id) #PresentreEdit
    render("edit", locals: {task: task_view_model})
  end

  def update
    task = Task.find_by(id: params[:id]) #Task<ActiveRecord
    task.content = params[:content]
    if task.save
      flash[:notice] = "やることを編集しました"
      redirect_to("/")
    else
      # viewに渡す変数を作成する
      task_id = task.id #Integer
      task_content = task.content #String or nil
      task_errors = task.errors #ActiveModel::Errors
      task_view_model = PresenterUpdate.new(content: task_content, errors: task_errors, id: task_id)
      render("edit", locals: {task: task_view_model})
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])
    if task.destroy
      flash[:notice] = "タスクを削除しました"
      redirect_to(request.referer)
    else
      flash[:notice] = "タスクの削除に失敗しました"
      redirect_to(request.referer)
    end
  end

  def done
    task = Task.find_by(id: params[:id])
    task.done_flag = 1
    task.image_status = "done.png"
    if task.save
      # @tasks = Task.where(done_flag: 0)
      redirect_to("/")
    else
      flash[:notice] = "保存に失敗しました"
      redirect_to(request.referer)
    end
  end

  def undone
    task = Task.find_by(id: params[:id])
    task.done_flag = 0
    task.image_status = "undone.png"
    if task.save!
      puts "保存"
      redirect_to("/tasks/fin_index")
    else
      flash[:notice] = "保存に失敗しました"
      redirect_to(request.referer)
    end
  end
end
