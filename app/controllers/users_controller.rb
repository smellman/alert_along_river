class UsersController < ApplicationController
  before_filter :load_user

  # GET /users
  # GET /users.json
  def index
    if @user
      redirect_to :action => :show
    end
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def login
    logger.debug(params)
    if params[:name].blank?
      flash[:error] = "Please input user name"
      respond_to do |format|
        format.html { render action: "index" }
      end
      return
    end
    if params[:password].blank?
      flash[:error] = "Please input password"
      respond_to do |format|
        format.html { render action: "index" }
      end
      return
    end
    user = User.where(:name => params[:name]).first.try(:authenticate, params[:password])
    unless user
      flash[:error] = "Invalid user name or password"
      respond_to do |format|
        format.html { render action: "index" }
      end
      return
    end
    session[:user] = user
    redirect_to :action => :show
    return
  end

  def logout
  end

  private

  def load_user
    @user = User.find_by_id(session[:user][:id]) if session[:user]
  end

  def login_check
    unless session[:user]
      redirect_to :controller => :users, :action => :index
      return false
    end
  end

end
