class Admin::UsersController < ApplicationController
  before_action :require_permission, only: [:update, :edit, :show]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def redirect_to_back(default = records_path)
    if request.env["HTTP_REFERER"].present? and request.env["HTTP_REFERER"] != request.env["REQUEST_URI"]
      redirect_to :back
    else
      redirect_to default
    end
  end

  def require_permission
    if !current_user.try(:admin?) and current_user.id != @user.id
      redirect_to_back
      flash[:alert] = "Get out, you do not have permission."
    end
  end

  def index
    if params[:approved] == "false"
      @users = User.where(approved: false)
    else
      @users = User.where(approved: true)
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to [:admin, @user], notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :approved, :team, :biography)
    end

end
