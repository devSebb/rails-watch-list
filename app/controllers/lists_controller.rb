class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def show
    @list = List.find(params[:id])
    @movies = @list.movies
  end

  def create
    @list = List.new(list_params)
    if @list.save
      redirect_to @list
    else
      render :new
    end
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to list_path(@list.list), status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
