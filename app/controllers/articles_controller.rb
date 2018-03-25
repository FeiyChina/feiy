class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show, :by_tag, :search]
  before_action :find_article, only: [:show, :like]

  def index
    if !article_params[:page] || article_params[:page] == '1'
      @main_article = Article.includes(:tags).main_article.first
    end
    @articles = Article.includes(:tags).decide_page(article_params[:page])
  end

  def show
    @suggestions = @article.suggestions
  end

  def search
    @articles = Article.by_tag(params[:category]) unless params[:category].blank?
    @articles = Article.search(params[:title]) unless params[:title].blank?
    @articles = @articles.page(article_params[:page] || '1').per(6)
    render template: 'articles/index'
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
    @article = Article.friendly.find(params[:id])  
    if params[:id] != @article.slug && params[:id]&.to_i != @article.id
      redirect_to article_path(@article), status: :moved_permanently 
    end
  end

  def article_params
    params.permit(:id, :page, :tag)
  end
end
