require_relative "base-strategy"

class QuantityStrategy < BaseStrategy
  def self.applicable?(context)
    context.condition_alpha == "paper" && context.condition_beta == "quantity"
  end

  def initialize(input, quantity_type:)
    super(input:)
    @quantity_type = quantity_type
  end

  def execute
    puts "Executing quantity strategy with quantity type: #{quantity_type}"
    build_result
  end

  private

  attr_reader :quantity_type

  def build_result
    super.merge(
      :quantity_type => quantity_type,
    )
  end
end
