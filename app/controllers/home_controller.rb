class HomeController < ApplicationController
  before_action :check_news_updates, only: %i[index]
  def index
    get_images = Proc.new { |x| Base64.encode64(get_file(x)) }
    @news = New.last(5)
    @b64_images = (0..2).map(&get_images)
  end

  private

  def get_file(image_id)
    url = "#{Rails.root}/app/assets/images/img-news-#{image_id}"
    return unless File.exist?(url)

    File.open(url).read
  end

  def check_news_updates
    return if New.updated?

    #news_service = NewsService.new
    #news_service.update_text_news
    #news_service.update_img_news
  end
end
