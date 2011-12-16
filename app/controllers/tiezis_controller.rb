class TiezisController < ApplicationController
  # GET /tiezis
  # GET /tiezis.json
  def index
    @tiezis = Tiezi.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tiezis }
    end
  end

  # GET /tiezis/1
  # GET /tiezis/1.json
  def show
    @tiezi = Tiezi.find(params[:id])
    @tiezi.create(@tiezi.url)
    @tiezi.chk_url
    @tiezi.fatch_tiezi
    @tiezi.next_url
    @tiezi.tuoshui
    @tz_content = @tiezi.to_something
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tiezi }
    end
  end

  # GET /tiezis/new
  # GET /tiezis/new.json
  def new
    @tiezi = Tiezi.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tiezi }
    end
  end

  # GET /tiezis/1/edit
  def edit
    @tiezi = Tiezi.find(params[:id])
  end

  # POST /tiezis
  # POST /tiezis.json
  def create
    @tiezi = Tiezi.new(params[:tiezi])

    respond_to do |format|
      if @tiezi.save
        format.html { redirect_to @tiezi, notice: 'Tiezi was successfully created.' }
        format.json { render json: @tiezi, status: :created, location: @tiezi }
      else
        format.html { render action: "new" }
        format.json { render json: @tiezi.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tiezis/1
  # PUT /tiezis/1.json
  def update
    @tiezi = Tiezi.find(params[:id])

    respond_to do |format|
      if @tiezi.update_attributes(params[:tiezi])
        format.html { redirect_to @tiezi, notice: 'Tiezi was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tiezi.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tiezis/1
  # DELETE /tiezis/1.json
  def destroy
    @tiezi = Tiezi.find(params[:id])
    @tiezi.destroy

    respond_to do |format|
      format.html { redirect_to tiezis_url }
      format.json { head :ok }
    end
  end
end
