require 'open-uri'
PAGE = 10
class Restaurant < ActiveRecord::Base
  def Restaurant::grasp
    count = 0
    PAGE.times.each do |page|
      doc = Nokogiri::HTML(open('http://www.yellowpages.com/new-york-ny/restaurants?g=New+York%2C+NY&page=' + (page + 1).to_s))
      doc.css('.listing-content').each do |content|
        unique_code = content.css('.business-name').data('lid')
        unless Restaurant.exists?(unique_code: unique_code)
          rt = Restaurant.new
          business_name = content.css('.business-name a')
          rt.detail_url = business_name.attr('href').value
          rt.title = business_name.attr('title').value
          rt.unique_code = unique_code 
          rt.phone_num = content.css('.business-phone').text.strip.delete("\n\t")
          rt.address = content.css('.listing-address').text.strip.delete("\n\t")
          rt.street = content.css('.listing-address .street-address').text.strip.delete("\n\t")
          rt.locality = content.css('.listing-address .locality').text.strip.delete("\n\t")
          rt.region = content.css('.listing-address .region').text.strip.delete("\n\t")
          rt.postal_code = content.css('.listing-address .postal-code').text.strip.delete("\n\t")
          rt.save
          count += 1
        end
      end
    end
    count
  end

end
