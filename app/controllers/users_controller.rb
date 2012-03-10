class UsersController < Devise::SessionsController
  load_and_authorize_resource
  # GET /users
  # GET /users.xml
  def index
    @search = User.search(params[:search])
    @users = @search.paginate(:page => params[:page], :per_page => 10, :conditions => {:organization_id => current_user.organization_id}, :order => "updated_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  def create
    super
  end
  
  def sign_out
    super
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
        format.json { respond_with_bip(@user) }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :user => :unprocessable_entity }
        format.json { respond_with_bip(@user) }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end