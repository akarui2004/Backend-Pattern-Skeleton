require_relative "resolver"

condition_alpha = "paper"
condition_beta = "paper_quantity"

resolver = StrategyResolver.new(condition_alpha:, condition_beta:)
strategy = resolver.resolve

puts strategy.inspect
