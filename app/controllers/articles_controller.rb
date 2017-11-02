class ArticlesController < ApplicationController
  before_action :find_article, only: [:show, :like]

  def index
    @articles = Article.page(article_params[:page] || 1).per(5)
  end

  def show
    @suggestions = Article.all.limit(5)
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
