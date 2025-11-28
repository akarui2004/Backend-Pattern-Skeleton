require_relative "../base-strategy"

class PaperQuantityStrategy < BaseStrategy
  def self.applicable?(context)
    context.condition_alpha == "paper" && context.condition_beta == "paper_quantity"
  end

  def initialize(input:, paper_quantity_type:)
    super(input:)
    @paper_quantity_type = paper_quantity_type
  end

  def execute
    puts "Executing paper quantity strategy with quantity type: #{paper_quantity_type}"
    build_result
  end

  private

  attr_reader :paper_quantity_type

  def build_result
    super.merge(
      :paper_quantity_type => paper_quantity_type,
    )
  end
end
