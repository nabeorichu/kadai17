class BlogsController < ApplicationController
  before_action :set_blog, only: [:show, :edit, :update, :drop, :destroy]

  # GET /blogs
  # GET /blogs.json
  def index
    flash.now[:notice] = "公開したブログ一覧"
    @blogs = Blog.where(status: 2)
  end

  # GET /blogs/1
  # GET /blogs/1.json
  def show
  end

  # GET /blogs/new
  def new
    @blog = Blog.new
  end

  # GET /blogs/1/edit
  def edit
  end

  # POST /blogs
  # POST /blogs.json
  def create
    @blog = Blog.new(blog_params)

    respond_to do |format|
      if @blog.save
        format.html { redirect_to @blog, notice: 'ブログ作りました' }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blogs/1
  # PATCH/PUT /blogs/1.json
  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: '編集しました' }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def drop
    @blog.status = 3
    @blog.update(status: 3 )
    respond_to do |format|
      format.html { redirect_to @blog, notice: 'ゴミ箱に入れました' }
      format.json { head :no_content }
    end
  end


  def draft
    @blogs = Blog.where(status: 1)
    flash.now[:notice] = "下書き一覧"
    render :index
  end

  def dropbox
    @blogs = Blog.where(status: 3)
    flash.now[:notice] = "ゴミ箱一覧"
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_params
      params.require(:blog).permit(:title, :status)
    end

end
