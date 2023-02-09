class Api::V1::UsersController < ApplicationController
  def index
    @u1=User.all
    render json: @u1
  end
  def show
    @u1=User.find_by(email: params[:email] )
    @id=User.ids
    @id.each do|i|
      if User.find(i).email==params[:email]
        render json: {fullname: "#{User.find(i).first_name} #{User.find(i).last_name}", age: User.find(i).age, email: params[:email]} 
      end
    end
  end
  def create
    @u1=User.create(user_params)
    if @u1.save
      render json: @u1
    else
      render error: {error:"unable to create"}, status: 400
    end
  end
  def update
    @u1=User.find(params[:id])
    if @u1
      @u1.update(user_params)
      render json: {message: "updated"}, status:200
    else
      render json: {message: "unable to update"}, status:400
    end
  end
  def destroy
    @u1.find(params[:id])
    if @u1.destroy
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
