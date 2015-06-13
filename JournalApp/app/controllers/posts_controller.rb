class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post
    else

    end
  end

  def new
    @post = Post.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
    #implicit call to the file in /app/views/posts/
    #that starts with show.* and is the request format
  end

  def update
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    render json: @post #sends back JSON response so server doesn't shit itself
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
