class StorageUnitsController < ApplicationController
  # GET /storage_units
  # GET /storage_units.xml
  def index
    @storage_units = StorageUnit.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @storage_units }
    end
  end

  # GET /storage_units/1
  # GET /storage_units/1.xml
  def show
    @storage_unit = StorageUnit.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @storage_unit }
    end
  end

  # GET /storage_units/new
  # GET /storage_units/new.xml
  def new
    @storage_unit = StorageUnit.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @storage_unit }
    end
  end

  # GET /storage_units/1/edit
  def edit
    @storage_unit = StorageUnit.find(params[:id])
  end

  # POST /storage_units
  # POST /storage_units.xml
  def create
    @storage_unit = StorageUnit.new(params[:storage_unit])

    respond_to do |format|
      if @storage_unit.save
        flash[:notice] = 'StorageUnit was successfully created.'
        format.html { redirect_to(@storage_unit) }
        format.xml  { render :xml => @storage_unit, :status => :created, :location => @storage_unit }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @storage_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /storage_units/1
  # PUT /storage_units/1.xml
  def update
    @storage_unit = StorageUnit.find(params[:id])

    respond_to do |format|
      if @storage_unit.update_attributes(params[:storage_unit])
        flash[:notice] = 'StorageUnit was successfully updated.'
        format.html { redirect_to(@storage_unit) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @storage_unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /storage_units/1
  # DELETE /storage_units/1.xml
  def destroy
    @storage_unit = StorageUnit.find(params[:id])
    @storage_unit.destroy

    respond_to do |format|
      format.html { redirect_to(storage_units_url) }
      format.xml  { head :ok }
    end
  end
end
