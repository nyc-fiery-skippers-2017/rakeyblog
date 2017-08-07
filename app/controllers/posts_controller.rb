class PostsController < ApplicationController
  before_action :find_post, only: [:edit, :update, :show, :delete]

  # Index action to render all posts
  def index
    @posts = Post.all
  end

  # New action for creating post
  def new
    @post = Post.new
  end

  # Create action saves the post into the database
  def create
    @post = Post.new
    if @post.save(post_params)
      flash[:notice] = "Successfully created post!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Error creating new post!"
      render :new
    end
  end

  # Edit action retrives the post and renders the edit page
  def edit
  end

  # Update action updates the post and renders the edit page
  def update
    if @post.update_attributes(post_params)
      flash[:notice] = "Successfully updated post!"
      redirect_to post_path(@posts)
    else
      flash[:alert] = "Error updating post!"
      render :edit
    end
  end

  # Show action renders the individual post after retriving the post id
  def show
    @post = Post.find(params[:id])
  end

  # Destroy action removes the post permanenetly from the database
  def destroy
    if @post.destroy
      flash[:notice] = "Successfully deleted post!"
      redirect_to post_path
    else
      flash[:alert] = "Error deleting post!"
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def find_post
    @post = Post.find(params[:id])
  end
end
