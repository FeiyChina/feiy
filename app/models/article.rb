class Article < ApplicationRecord
  acts_as_taggable
  scope :without_current, ->(id) { where.not(id: id) }
  scope :published, -> { where(is_published: true).order(published_at: :desc) }
  scope :published_without_main, -> { where(is_published: true, is_main_article: false).order(published_at: :desc) }
  scope :main_article, -> { where(is_main_article: true) }
  before_save :check_for_publication_status
  before_save :set_main_article
  has_attachment :photo
  acts_as_commentable
  acts_as_votable
  belongs_to :user

  def suggestions
    if tags.blank?
      Article.published.without_current(id).limit(3)
    else
      Article.tagged_with(tags.first).without_current(id).limit(3)
    end
  end

  def self.decide_page(page)
    if !page || page == '1'
      Article.published_without_main.page(1).per(6)
    else
      Article.published_without_main.page(page).per(6)
    end
  end

  def self.search(criteria)
    Article.where('title LIKE ?', "%#{criteria}%")
           .or(Article.where('body LIKE ?', "%#{criteria}%"))
  end

  def self.by_tag(tag)
    Article.tagged_with(tag)
           .where(is_published: true)
  end

  private

  def check_for_publication_status
    if (is_published_was == false) && (is_published == true) && published_at_was.nil?
      self.published_at = Time.zone.now
    end
  end

  def set_main_article
    if (is_main_article_was == false) && (is_main_article == true)
      Article.where.not(id: id).update_all(is_main_article: false)
    end
  end
end
