class CategoriesController < ApplicationController

  before_action :require_admin, except:[:show, :index]
  before_action :find_user, except:[:show]

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
    @articles = @category.articles.paginate(page: params[:page], per_page: 5)
  end

  def index
    @categories = Category.all.paginate(page: params[:page], per_page: 5)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = "Category was created successfully"
      redirect_to @category
    else
      render 'new'
    end
  end
  def edit
    @category = Category.find(params[:id])
  end
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:notice] = "Successfully updated the name of category"
      redirect_to categories_path
    else 
      render 'edit'
    end
  end

  private 
  def category_params 
    params.require(:category).permit(:name)
  end
  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:notice] = "This action can only performed by admin"
      redirect_to categories_path
    end
  end
  def find_user
    @user = current_user
  end
end