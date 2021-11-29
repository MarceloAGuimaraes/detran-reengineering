class NewsService
  def initialize
    @agent = Mechanize.new{ |agent|
    agent.keep_alive = true
    agent.max_history = 0
  }
  end

  def update_text_news
    page = @agent.get('https://www.detran.mg.gov.br/sobre-o-detran-1/sala-de-imprensa/noticias')
    current_leading = page.xpath("//*[@class='list-group list-group-flush']//a")
    current_leading.each do |t|
      begin
        notice = New.new
        notice.content = t.css('h6').children.inner_text
        notice.link = t.attributes["href"].value
        notice.date = Date.today
        notice.save!
      rescue => e
        New.create(log_error: e.message)
      end
    end
  end

  def update_img_news
    delete_images
    page = @agent.get('https://detran.mg.gov.br/')
    leading_index = 0
    3.times do
      begin
        current_leading = page.xpath("//*[@class='icone-rodape img-fluid']")[leading_index]
        image_url = current_leading.attr("src").to_s.gsub(' ', '%20')
        next unless image_url.present?

        image_url = "https://detran.mg.gov.br#{image_url}"
        @agent.get(image_url).save Rails.root.join("app/assets/images/img-news-#{leading_index}").to_s
        leading_index += 1
      rescue
        next
      end
    end
  end

  private

  def delete_images
    [0, 1, 2].each do |i|
      path = Rails.root.join('app', 'assets', 'images', "img-news-#{i}").to_s
      next unless File.exist?(path)

      File.delete(path)
    end
  end
end
