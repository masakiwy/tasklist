class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(newtask_sec)
    if @task.save
      flash[:success] = 'Taskが正常に登録されました'
      redirect_to tasks_path
    else
      flash.now[:danger] = 'Taskが正常に登録されませんでした'
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    
    if @task.update(newtask_sec)
      flash[:success] = 'Taskが正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが正常に更新されませんでした'
      render :new
    end
    
  end
  
  def destroy
    @deletask = Task.find(params[:id])
    @deletask.destroy
    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_url
  end
  
  def newtask_sec
    params.require(:task).permit(:content, :status)
  end
end
