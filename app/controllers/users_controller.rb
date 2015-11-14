class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  def index
    @users = User.all#モデルの全て（ここではnameとemail）をコントローラ変数(@users)に代入 
  end

  def create#submitを実行したときに行われる内容
    @user = User.new(user_params)
    #変数(@user)にモデルのインスタンス変数を代入。paramsメソッド（小文字モデル名.params）で値を受け取る
    @user.save#データベースに保存
    redirect_to root_path , notice: 'ok'#rootページにアクセス、その際、noticeで一言表示させる
  end
  
  def edit#編集画面に来たとき実行されるアクション
  end
  
  def update#保存
    if @user.update(user.params)
      redirect_to root_path
    else
      render 'edit'
    end
  end
  
  def destroy
    @user.destroy
    redirect_to root_path
  end

 private#ストロングデータといい、検証し、不正操作を防ぐもの
   
  def user_params#←paramsメソッド。入力値を受け取る_paramsの前に小文字でモデル名を入れる
    params.require(:user).permit(:name, :email)#入力値の属性と内容を受け取る。
    #repuere(key)ストロングデータのキーを検証する構文。存在すればキーがpermitの内容だけを受け取る。
  end
  
  def set_user
    @user = User.find(params[:id])
  end
end