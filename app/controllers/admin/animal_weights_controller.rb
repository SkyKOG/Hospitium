class Admin::AnimalWeightsController < Admin::ApplicationController
  load_and_authorize_resource
  # GET /animal_weights
  # GET /animal_weights.xml
  def index
    @search = AnimalWeight.search(params[:search])
    @animal_weights = @search.paginate(:page => params[:page], :per_page => 10, :conditions => {:organization_id => current_user.organization_id}, :order => "updated_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @animal_weights }
      format.xls { send_data AnimalWeight.find(:all, :conditions => {:organization_id => current_user.organization_id}).to_xls, content_type: 'application/vnd.ms-excel', filename: 'animal_weight.xls' }
    end
  end

  # GET /animal_weights/1
  # GET /animal_weights/1.xml
  def show
    @animal_weight = AnimalWeight.find(params[:id])
    @animals = Animal.where(:organization_id => current_user.organization_id).collect{|x| [x.id.to_s,x.name.to_s]}
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @animal_weight }
    end
  end

  # GET /animal_weights/new
  # GET /animal_weights/new.xml
  def new
    @animal_weight = AnimalWeight.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @animal_weight }
      format.js
    end
  end

  # GET /animal_weights/1/edit
  def edit
    @animal_weight = AnimalWeight.find(params[:id])
  end

  # POST /animal_weights
  # POST /animal_weights.xml
  def create
    @animal_weight = AnimalWeight.new(params[:animal_weight])
    @animal_weight.organization_id = current_user.organization_id
    respond_to do |format|
      if @animal_weight.save
        format.html { 
          redirect_to(:back, :notice => 'Animal Weight was successfully created.')
          }
        format.xml  { render :xml => @animal_weight, :status => :created, :location => @animal_weight }
        format.js
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @animal_weight.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /animal_weights/1
  # PUT /animal_weights/1.xml
  def update
    @animal_weight = AnimalWeight.find(params[:id])

    respond_to do |format|
      if @animal_weight.update_attributes(params[:animal_weight])
        format.html { redirect_to(@animal_weight, :notice => 'Animal weight was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @animal_weight.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /animal_weights/1
  # DELETE /animal_weights/1.xml
  def destroy
    @animal_weight = AnimalWeight.find(params[:id])
    @animal_weight.destroy

    respond_to do |format|
      format.html { redirect_to(animal_weights_url) }
      format.xml  { head :ok }
    end
  end
end
