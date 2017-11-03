class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :by_tag]
  before_action :find_article, only: [:show, :like]

  def index
    if !article_params[:page] || article_params[:page] == '1'
      @main_article = Article.includes(:tags).main_article.first
    end
    @articles = Article.includes(:tags).decide_page(article_params[:page])
  end

  def show
    @suggestions = Article.published.limit(5)
  end

  def like
    @article.liked_by current_user
    redirect_to article_path(@article)
  end

  def by_tag
    @articles = Article.by_tag(article_params[:tag])
                       .page(article_params[:page] || '1').per(6)
    render template: 'articles/index'
  end

  private

  def find_article
    @article = Article.find(article_params[:id])
  end

  def article_params
    params.permit(:id, :page, :tag)
  end
end
