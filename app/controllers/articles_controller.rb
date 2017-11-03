class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :find_article, only: [:show, :like]

  def index
    if !article_params[:page] || article_params[:page] == '1'
      @main_article = Article.main_article.first
    end
    @articles = Article.decide_page(article_params[:page])
  end

  def show
    @suggestions = Article.published.limit(5)
  end

  def like
    @article.liked_by current_user
    redirect_to article_path(@article)
  end

  private

  def find_article
    @article = Article.find(article_params[:id])
  end

  def article_params
    params.permit(:id, :page)
  end
end
