class AreasController < ApplicationController
  before_filter :admin?
  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.all
    @target_users = User.where(User.arel_table[:location].not_eq nil)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @areas }
    end
  end

  # GET /areas/1
  # GET /areas/1.json
  def show
    @area = Area.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/new
  # GET /areas/new.json
  def new
    @area = Area.new
    @other_areas = Area.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @area }
    end
  end

  # GET /areas/1/edit
  def edit
    @area = Area.find(params[:id])
    @other_areas = Area.where('id != ?', params[:id])
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(params[:area])

    respond_to do |format|
      if @area.save
        format.html { redirect_to @area, notice: 'Area was successfully created.' }
        format.json { render json: @area, status: :created, location: @area }
      else
        format.html { render action: "new" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /areas/1
  # PUT /areas/1.json
  def update
    @area = Area.find(params[:id])

    respond_to do |format|
      if @area.update_attributes(params[:area])
        format.html { redirect_to @area, notice: 'Area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area = Area.find(params[:id])
    @area.destroy

    respond_to do |format|
      format.html { redirect_to areas_url }
      format.json { head :no_content }
    end
  end

  def append_child
    @area = Area.find(params[:id])
    @can_append_child_areas = @area.can_append_child
  end

  def set_child_area
    @area = Area.find(params[:id])
    @child = Area.find(params[:child_id])
    if @area.append_child(@child)
      @area.save
      @child.save
      respond_to do |format|
        format.html { redirect_to @area, notice: 'Area was successfully updated.' }
        format.json { head :no_content }
      end
    end
  end

  def alert
    @area = Area.find(params[:id])
    @alert_areas = @area.alert_areas
    @target_users = @area.target_users
  end
end
