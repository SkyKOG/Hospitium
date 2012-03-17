class Admin::PostsController < Admin::ApplicationController
  load_and_authorize_resource
  # GET /posts
  #caches_action :index, :cache_path => Proc.new { |controller| controller.params },:layout => false, :expires_in => 180.minutes
  
  # GET /posts.xml
  def index
    canonical_url("/posts")
    #@posts = Rails.cache.fetch('public_posts_listing', :expires_in => 10.minutes) do
      #@posts = Post.paginate(:page => params[:page], :per_page => 10, :order => "created_at DESC")
    #end
    #@posts = Post.paginate(:page => params[:page], :per_page => 10, :order => "created_at DESC")
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
      format.json  { render :json => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    canonical_url("/posts/#{params[:id]}")
    require_dependency "Post"
    @post = Rails.cache.fetch("public_post_#{params[:id]}", :expires_in => 180.minutes) do
      Post.find(params[:id])
    end
    #@post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(@post, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(@post, :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end