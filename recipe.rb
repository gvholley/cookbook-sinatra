class Recipe
  attr_reader :name
  attr_reader :description
  attr_reader :prep_time
  attr_accessor :status
  attr_reader :difficulty

  def initialize(name, description, prep_time, difficulty, status = false)
    @name = name
    @description = description
    @prep_time = prep_time
    @difficulty = difficulty
    if status == "true"
      @status = true
    else
      @status = false
    end
  end
end
