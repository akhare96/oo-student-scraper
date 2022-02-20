require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))

    students = []

    doc.css(".student-card").each {|student| 
    profile_link = student.css("a").attribute("href").value
    student_name = student.css(".student-name").text
    student_location = student.css(".student-location").text
    info_hash = {location: student_location, name: student_name, profile_url: profile_link}
    students << info_hash
    }

    students
  end

  def self.scrape_profile_page(profile_url)
    student_info = {}
    doc = Nokogiri::HTML(open(profile_url))
    student_links = doc.css(".social-icon-container a").collect {|student| student.attribute("href").value}
    student_links.each {|link|
    student_info[:twitter] = link if link.start_with?("https://tw")
    student_info[:linkedin] = link if link.start_with?("https://www.l")
    student_info[:github] = link if link.start_with?("https://g")
    student_info[:blog] = doc.css(".social-icon-container a")[3].attribute("href").value if doc.css(".social-icon-container a")[3]
    student_info[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote").text
    student_info[:bio] = doc.css(".description-holder p").text if doc.css(".description-holder p")
    }
    student_info
  end

end

 