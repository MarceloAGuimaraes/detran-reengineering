class HomeController < ApplicationController
  before_action :check_news_updates, only: %i[index]
  def index
    @news = New.last(5)
  end

  private

  def check_news_updates
    return if New.updated?

    news_service = NewsService.new
    news_service.update_text_news
    news_service.update_img_news
  end
end
