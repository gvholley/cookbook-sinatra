require 'nokogiri'
require 'open-uri'
require_relative 'recipe'

class Importer
  def initialize(query)
    @query = query
  end

  def import
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{@query}"
# 1. We get the HTML page content
    html_content = open(url)
# 2. We build a Nokogiri document from this file
    doc = Nokogiri::HTML((html_content), nil, 'utf-8')
    results = []
# 3. We search for the correct elements containing the items' title in our HTML doc
    doc.search('.node-recipe').first(5).each do |card|
  # 4. For each item found, we extract its title and print it
      title_name = card.search('.teaser-item__title').text.strip.split.first(5).join(" ")#store in a hash
      description_name = card.search('.teaser-item__text-content').text.strip
      prep_time = card.search('.teaser-item__info-item.teaser-item__info-item--total-time').text.strip
      difficulty = card.search('.teaser-item__info-item.teaser-item__info-item--skill-level').text.strip
      Recipe.new(title_name, description_name, prep_time, difficulty)
      results << Recipe.new(title_name, description_name, prep_time, difficulty)
    end
    results
  end
end

