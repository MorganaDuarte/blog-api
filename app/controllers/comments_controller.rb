class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show update destroy ]

  # GET /comments
  def index
    @comments= Article.find(params[:article_id]).comments
    
    render json: @comments
  end

  # GET /comments/1
  def show
    render json: @comment
  end

  # POST /comments
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)

    return render json: Article.find(params[:article_id]).comments if @comment.save

    render json: @comment.errors, status: :unprocessable_entity
  end

  # PATCH/PUT /comments/1
  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.update(comment_params)

    return render json: Article.find(params[:article_id]).comments if @comment

    render json: @comment.errors, status: :unprocessable_entity
  end

  # DELETE /comments/1
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    render json: Article.find(params[:article_id]).comments
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
