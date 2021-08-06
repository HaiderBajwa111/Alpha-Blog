class ArticlesController < ApplicationController
  before_action :set_articles, only: [:show, :edit, :update, :destroy]
  def show
  
  end

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new()
  end

  def edit
  end

  def create
    @article = Article.new(params.require(:article).permit(:title , :description))
    if @article.save
      flash[:notice] = "Article created Successfully"
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def update
    if@article.update(params.require(:article).permit(:title , :description))
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

end