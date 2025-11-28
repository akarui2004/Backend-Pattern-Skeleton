class BaseStrategy
  Context = Struct.new(:condition_alpha, :condition_beta, keyword_init: true)

  class << self
    def applicable?(context)
      raise NotImplementedError, "Subclasses must implement this method"
    end
  end

  def initialize(input:)
    @input = input
  end

  def execute
    raise NotImplementedError, "Subclasses must implement this method"
  end

  private
  
  attr_reader :input

  def build_result
    {
      :input => input,
    }
  end
end
