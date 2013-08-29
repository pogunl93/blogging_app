class PostController < ApplicationController

  def new

  end

  def create
    @post = Post.create(post_params)
    @user = User.find(current_user.id.to_s)
    if @user == current_user
      @user.posts << @post
    end
    if @post.save
      flash[:notice] = "Blog Post created successfully"
      redirect_to root_path
    else 
      flash[:notice] = "There was a problem creating your post"
      redirect_to "/post/new"
    end
  end

  def edit
  end

  def update
  end

  def show
    @post = Post.find(params[:id])
  end

  def index
    @user = User.find(params[:user_id])
    @post = Post.all
  end

  private 

  def post_params
    params.require(:post).permit :post_name, :post_description, :post_text
  end 

end
