class ApplicationController < ActionController::Base
  def task_id_nil?
    unless Task.find_by(id: params[:id])
      redirect_to("/")
    end
  end
end
