class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy,:signed]
   
      before_action :authenticate_user!, :except => [:index]
before_action :signed, only: [:edit,:update,:destroy]
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
    @paginate = @articles.paginate(:page => params[:page], :per_page => 4)
     if params[:search]
    @articles = Article.search(params[:search]).order("created_at DESC")
  else
    @articles = Article.all
  end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show

    @articles= Article.all
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comment.article_id = @article.id
    @article1= Article.where('id != ?',params[:id])
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
 def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    respond_to do |format|
      if @article.save(article_params)
        @article=Article.find(@article.id)
      
        format.html{ render :crop}
        #format.html { redirect_to @article, notice: 'Article was successfully created.' }
        #format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
          format.html{ render :crop}
        # format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        # format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def profile
    # @profile= Article.find(params[:id])
    @profile1 =User.find(params[:id])

  end
  def crop

    @article=Article.find(params[:id])
       
       @article.image_crop_x=params[:article][:image_crop_x]
        @article.image_crop_y=params[:article][:image_crop_y]
       @article.image_crop_w=params[:article][:image_crop_w]
        @article.image_crop_h=params[:article][:image_crop_h]
             @article.image_aspect=params[:article][:image_aspect]
        
    
        @article.save
        redirect_to article_path(@article), notice: 'Image was successfully cropped.' 
     
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end
     def signed

      
      if current_user.id != @article.user_id
        flash[:notice] = "You are not eligible"
        redirect_to root_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :body, :tag_list, :image, :user_id,:image_crop_x,:image_crop_y,:image_crop_w,:image_crop_h,:image_aspect)
    end
end
