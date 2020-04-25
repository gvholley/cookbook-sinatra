# repository
require 'csv'
require_relative 'recipe'

filepath = 'recipes.csv'


class Cookbook
  attr_reader :recipes
  def initialize(csv_file_path)
    @recipes = []
    @csv_file_path = csv_file_path
    read_csv
  end

  def read_csv
    CSV.foreach(@csv_file_path) do |row|
      @recipes << Recipe.new(row[0], row[1], row[2], row[3], row[4])
    end
  end

  def write_csv
    csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
    CSV.open(@csv_file_path, 'wb', csv_options) do |csv|
      @recipes.each do |recipe|
        recipe.name
      csv << [recipe.name, recipe.description, recipe.prep_time, recipe.difficulty, recipe.status]
      end
    end
  end

  def all
    @recipes
  end

  def add_recipe(recipe)
    # Returns all the recipes
    @recipes << recipe
    write_csv
  end

  def remove_recipe(recipe_index)
    # Removes recipe from the cookbook
    @recipes.delete_at(recipe_index)
    write_csv
  end

  def mark_recipe(recipe_index)
    # Updates recipe from [ ] to [ X ]
    @recipes[recipe_index].status = true
    write_csv
  end
end

