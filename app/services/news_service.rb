class NewsService
    def initialize
      @agent = Mechanize.new{ |agent|
      agent.keep_alive = true
      agent.max_history = 0
    }
    end

    def update_text_news
      page = @agent.get('https://www.detran.mg.gov.br/sobre-o-detran/comunicados/noticias')
      current_leading = page.xpath("//*[@id='conteudo']//*[@class='category']//tbody//tr")
      current_leading.each do |t|
        begin 
          notice = New.new
          notice.content = t.css('td')[0].css('a').inner_text.strip!
          notice.link = t.css('td')[0].css('a').attribute('href').value
          notice.date = t.css('td')[1].inner_text.strip!
          notice.save!
        rescue => e
          New.create(log_error: e.message)
        end
      end
    end

    def update_img_news
      page = @agent.get('https://www.detran.mg.gov.br/')
      leading_index = 0
      3.times do
        begin
          current_leading = page.xpath("//*[@class='items-leading']//*[@class='leading-#{leading_index}']//p//a//img")
          image_url = current_leading.first.attributes['src'].to_s.gsub(' ', '%20')
          if image_url.present?
            image_url = "https://www.detran.mg.gov.br#{image_url}"
            @agent.get(image_url).save Rails.root.join("app/assets/images/img-news-#{leading_index}").to_s
          else
            next
          end
          leading_index += 1
        rescue
          next
        end
      end
    end
end  