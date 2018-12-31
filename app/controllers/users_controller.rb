class UsersController < ApplicationController
  def index
    @users = User.order(:id).page params[:page]
  end

  def show
    @user = User.find(params[:id])

    # TODO: Paginate this?
    @purchased_releases = @user.releases
  end
end