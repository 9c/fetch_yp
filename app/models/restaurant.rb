require 'open-uri'
PAGE = 10
class Restaurant < ActiveRecord::Base
  def Restaurant::grasp
    count = 0
    arr_list = Array.new
    PAGE.times.each do |page|
      doc = Nokogiri::HTML(open('http://www.yellowpages.com/new-york-ny/restaurants?g=New+York%2C+NY&page=' + (page + 1).to_s))
      doc.css('.listing-content').each do |content|
        unit = Hash.new
        business_name = content.css('.business-name a')
        unit[:detail_url] = business_name.attr('href').value
        unit[:title] = business_name.attr('title').value
        unit[:unique_code] = content.css('.business-name').data('lid')
        unit[:phone_num] = content.css('.business-phone').text.strip.delete("\n\t")
        unit[:address] = content.css('.listing-address').text.strip.delete("\n\t")
        unit[:street] = content.css('.listing-address .street-address').text.strip.delete("\n\t")
        unit[:locality] = content.css('.listing-address .locality').text.strip.delete("\n\t")
        unit[:region] = content.css('.listing-address .region').text.strip.delete("\n\t")
        unit[:postal_code] = content.css('.listing-address .postal-code').text.strip.delete("\n\t")
      end
    end

  end

end
