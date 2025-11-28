require_relative "../base-strategy"

class PaperWeightStrategy < BaseStrategy
  def self.applicable?(context)
    context.condition_alpha == "paper" && context.condition_beta == "paper_weight"
  end

  def initialize(input:, weight_type:)
    super(input:)
    @weight_type = weight_type
  end

  def execute
    puts "Executing paper weight strategy with weight type: #{weight_type}"
    build_result
  end

  private

  attr_reader :weight_type

  def build_result
    super.merge(
      :weight_type => weight_type,
    )
  end
end
