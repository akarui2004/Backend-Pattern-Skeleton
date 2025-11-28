require_relative "quantity-strategy"
require_relative "paper/quantity-strategy"
require_relative "paper/weight-strategy"

class StrategyResolver
  STRATEGIES = [
    QuantityStrategy,
    PaperQuantityStrategy,
    PaperWeightStrategy,
  ]

  def initialize(condition_alpha:, condition_beta:)
    @condition_alpha = condition_alpha
    @condition_beta = condition_beta
  end

  def resolve
    context = build_context
    strategy = STRATEGIES.find { |strategy_class| strategy_class.applicable?(context) }

    raise ArgumentError, "No strategy found for context: #{context}" unless strategy

    strategy
  end

  private

  attr_reader :condition_alpha, :condition_beta

  def build_context
    BaseStrategy::Context.new(condition_alpha:, condition_beta:)
  end
end
