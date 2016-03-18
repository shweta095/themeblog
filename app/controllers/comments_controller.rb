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
   @comment = Comment.find(params[:id])
   @article = Article.find(params[:article_id])


  end

  # POST /comments
  # POST /comments.json



  def create 
  @article = Article.find(params[:article_id])
  @comment = Comment.new(comment_params)

  @comment.article_id = params[:article_id]
  @comment.user_id = current_user.id 
  @comment.save
  #redirect_to article_path(@comment.article_id)
   respond_to do |format|
    format.js
   end 
 end
  




  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update

    @comment = Comment.find(params[:id])
    @comment.update(comment_params)
     redirect_to article_path(@comment.article_id)
    #respond_to do |format|
      #if @comment.update(comment_params)
        #format.html { redirect_to article_path(@article.id), notice: 'Comment was successfully updated.' }
       # format.json { render :show, status: :ok, location: @comment }
      #else
        #format.html { render :edit }
       # format.json { render json: @comment.errors, status: :unprocessable_entity }
     #end
    #end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json


 def destroy

    @comment = Comment.find(params[:id])
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
