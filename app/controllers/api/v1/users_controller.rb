class Api::V1::UsersController < ApplicationController
  def index
   @user=User.all
    render json:@user
  end
  def show
   @user=User.find_by(email: params[:email] )
    @id=User.ids
    @id.each do|i|
      if User.find(i).email==params[:email]
        render json: {fullname: "#{User.find(i).first_name} #{User.find(i).last_name}", age: User.find(i).age, email: params[:email]} 
      end
    end
  end
  def create
   @user=User.create(user_params)
    if@user.save
      render json:@user
    else
      render json: {error:"unable to create"}, status: 400
    end
  end
  def update
   @user=User.find(params[:id])
    if@user
     @user.update(user_params)
      render json: {message: "updated"}, status:200
    else
      render json: {message: "unable to update"}, status:400
    end
  end
  def destroy
   @user.find(params[:id])
    if@user.destroy
      render json: {message: "user deleted"}, status:200
    else
      render json: {error: "delete failed"}
    end
  end
  private
  def user_params
    params.permit(:first_name, :last_name, :email, :age)
  end
end
