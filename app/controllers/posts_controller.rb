class PostsController < ApplicationController
  before_action :set_params, except: [:new, :create, :index, :search]

  def search
    if params[:search].blank?
      redirect_to(posts_path, alert: "Empty field!") and return
    else
       keyword = params[:search]
       @posts = Post.where("title LIKE ?", "%#{keyword}%")
    end
  end

  def index
    @posts = Post.paginate(page: params[:page], per_page: 5).order("created_at DESC")
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      respond_to do |format|
        format.html { redirect_to @post, notice: 'Post was successfully created' }
        format.js
    end
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path
    else
      render action: "edit"
    end
  end

  def destroy
    @post.destroy
 
    respond_to do |format|
      format.html { respond_to post_params, notice: 'Post was successfully Deleted '}
      format.json { head :no_content }
      format.js
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_params
    @post = Post.find(params[:id])
  end

end
