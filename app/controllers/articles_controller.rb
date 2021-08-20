class ArticlesController < ApplicationController
  before_action :set_articles, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:show, :index]
  before_action :verify_same_user, only: [:edit, :update, :destroy]
  def show
  
  end

  def index
    @q = Article.ransack(params[:q])
    @articles = @q.result.paginate(page: params[:page], per_page: 5)
    #@articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new()
  end

  def edit
  end

  def create
    @article = Article.new(params.require(:article).permit(:title , :description, category_ids: []))
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article created Successfully"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if@article.update(params.require(:article).permit(:title , :description, category_ids: []))
      flash[:notice]="Article updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private 
  def set_articles
    @article = Article.find(params[:id])
  end

  def verify_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:notice] = "You can edit or delete your own articles"
      redirect_to @article
    end
  end
end