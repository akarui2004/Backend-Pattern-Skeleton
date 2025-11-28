require_relative "resolver"

condition_alpha = "paper"
condition_beta = "paper_quantity"

resolver = StrategyResolver.new(condition_alpha:, condition_beta:)
strategy = resolver.resolve

puts "--------------------------------"
puts "Strategy: #{strategy.class.name}"

init_strategy = strategy.new(input: { quantity: 10 }, paper_quantity_type: "A4")
result = init_strategy.execute

puts "--------------------------------"
puts result.inspect
