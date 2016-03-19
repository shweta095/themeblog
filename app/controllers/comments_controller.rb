class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
 # def show
 # end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  @article = Article.find(params[:article_id])
   @comment = Comment.find(params[:id])
   respond_to do |format|
   format.js
 end
  end

  # POST /comments
  # POST /comments.json



  def create 
  @article = Article.find(params[:article_id])
  @comment = Comment.new(comment_params)

  @comment.article_id = params[:article_id]
  @comment.user_id = current_user.id 
  @comment.save

   respond_to do |format|
    format.js
   end 
 end
  




  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @article = Article.find(params[:article_id])
    @comment = Comment.find(params[:id])
  @comment.article_id = params[:article_id]
  @comment.user_id = current_user.id 
  @comment.save

    @comment.update(comment_params)
     respond_to do |format|
      format.js
    end
    
  end




 def destroy

 @article = Article.find(params[:article_id])
   
    @comment.destroy
    
    #redirect_to article_path(@comment.article_id)
    respond_to do |format|
    format.js
    end
  end
    


 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:author_name, :body, :article_id, :user_id)
    end
end
