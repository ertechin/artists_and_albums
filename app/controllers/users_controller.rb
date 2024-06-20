class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]

  def index
    @users = User.all
  end

  def show; end

  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def album_detail
    @album_detail = AlbumDetail.find(params[:album_detail_id])
  end

  #def sync; end

  def search
    @users = if params[:commit] == 'Search' && params[:query].present?
      User.search_user_name(params[:query])
    else
      User.all
    end

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end