# Strategy Resolver Pattern

A flexible implementation of the Strategy Pattern with automatic strategy resolution based on context conditions. This pattern allows you to dynamically select and execute different strategies based on runtime conditions without using complex if/else or case statements.

## Overview

The Strategy Resolver Pattern combines the classic Strategy Pattern with a resolver mechanism that automatically selects the appropriate strategy based on context conditions. This makes your code more maintainable, extensible, and follows the Open/Closed Principle.

## Architecture

### Components

1. **BaseStrategy** - Abstract base class that all strategies inherit from
2. **StrategyResolver** - Resolves and returns the appropriate strategy class based on context
3. **Concrete Strategies** - Specific implementations that handle different scenarios

### File Structure

```
strategy-resolver/
├── base-strategy.rb          # Base class for all strategies
├── resolver.rb                # Strategy resolver that selects strategies
├── quantity-strategy.rb       # Example strategy implementation
├── paper/
│   ├── quantity-strategy.rb   # Paper-specific quantity strategy
│   └── weight-strategy.rb     # Paper-specific weight strategy
└── test.rb                    # Example usage
```

## How It Works

1. **Context Creation**: The resolver creates a context object with condition values (`condition_alpha`, `condition_beta`)
2. **Strategy Selection**: The resolver iterates through registered strategies and finds the first one where `applicable?` returns `true`
3. **Strategy Execution**: The selected strategy class is returned, which can then be instantiated and executed

## Usage

### Basic Example

```ruby
require_relative "resolver"

# Create a resolver with conditions
resolver = StrategyResolver.new(
  condition_alpha: "paper",
  condition_beta: "paper_quantity"
)

# Resolve the appropriate strategy class
strategy_class = resolver.resolve

# Instantiate and execute the strategy
strategy = strategy_class.new(input: "some input", paper_quantity_type: "sheets")
result = strategy.execute
```

### Running the Test

```bash
ruby strategy-resolver/test.rb
```

## Creating New Strategies

### Step 1: Create Your Strategy Class

Create a new file (e.g., `my-strategy.rb`) that inherits from `BaseStrategy`:

```ruby
require_relative "base-strategy"

class MyStrategy < BaseStrategy
  # Define when this strategy is applicable
  def self.applicable?(context)
    context.condition_alpha == "my_alpha" && 
    context.condition_beta == "my_beta"
  end

  # Initialize with your specific parameters
  def initialize(input:, my_param:)
    super(input: input)
    @my_param = my_param
  end

  # Implement the strategy logic
  def execute
    puts "Executing my strategy with param: #{my_param}"
    build_result
  end

  private

  attr_reader :my_param

  # Optionally override build_result to add custom fields
  def build_result
    super.merge(
      :my_param => my_param,
      :custom_field => "value"
    )
  end
end
```

### Step 2: Register Your Strategy

Add your strategy class to the `STRATEGIES` array in `resolver.rb`:

```ruby
require_relative "my-strategy"

class StrategyResolver
  STRATEGIES = [
    QuantityStrategy,
    PaperQuantityStrategy,
    PaperWeightStrategy,
    MyStrategy,  # Add your new strategy here
  ]
  # ... rest of the code
end
```

### Step 3: Use Your Strategy

```ruby
resolver = StrategyResolver.new(
  condition_alpha: "my_alpha",
  condition_beta: "my_beta"
)

strategy_class = resolver.resolve
strategy = strategy_class.new(input: "data", my_param: "value")
result = strategy.execute
```

## Strategy Priority

Strategies are evaluated in the order they appear in the `STRATEGIES` array. The **first** strategy where `applicable?` returns `true` will be selected. Make sure to order your strategies from most specific to least specific if you have overlapping conditions.

## Context Structure

The context is a `Struct` with the following fields:

- `condition_alpha` - First condition for strategy selection
- `condition_beta` - Second condition for strategy selection

You can extend the context by modifying `BaseStrategy::Context`:

```ruby
class BaseStrategy
  Context = Struct.new(:condition_alpha, :condition_beta, :condition_gamma, keyword_init: true)
  # ...
end
```

## Benefits

1. **Separation of Concerns**: Each strategy encapsulates its own logic
2. **Easy to Extend**: Add new strategies without modifying existing code
3. **Testable**: Each strategy can be tested independently
4. **Maintainable**: No complex conditional logic scattered throughout the codebase
5. **Flexible**: Change strategy selection logic by modifying the resolver

## Example Strategies

### QuantityStrategy
- **Conditions**: `condition_alpha == "paper"` AND `condition_beta == "quantity"`
- **Purpose**: Handles general quantity-based operations

### PaperQuantityStrategy
- **Conditions**: `condition_alpha == "paper"` AND `condition_beta == "paper_quantity"`
- **Purpose**: Handles paper-specific quantity operations

### PaperWeightStrategy
- **Conditions**: `condition_alpha == "paper"` AND `condition_beta == "paper_weight"`
- **Purpose**: Handles paper weight-based operations

## Error Handling

If no strategy is found for the given context, the resolver will raise an `ArgumentError`:

```ruby
resolver = StrategyResolver.new(
  condition_alpha: "unknown",
  condition_beta: "unknown"
)
resolver.resolve  # Raises ArgumentError: No strategy found for context
```

## Best Practices

1. **Keep strategies focused**: Each strategy should handle one specific scenario
2. **Use descriptive names**: Strategy class names should clearly indicate their purpose
3. **Document conditions**: Make `applicable?` conditions clear and well-documented
4. **Test strategies independently**: Write unit tests for each strategy
5. **Order matters**: Place more specific strategies before general ones in the `STRATEGIES` array

## Extending the Pattern

### Adding More Context Fields

To add more context fields:

1. Update `BaseStrategy::Context`:
```ruby
Context = Struct.new(:condition_alpha, :condition_beta, :condition_gamma, keyword_init: true)
```

2. Update `StrategyResolver#build_context`:
```ruby
def build_context
  BaseStrategy::Context.new(
    condition_alpha: condition_alpha,
    condition_beta: condition_beta,
    condition_gamma: condition_gamma
  )
end
```

3. Update `StrategyResolver#initialize` to accept the new parameter

### Custom Resolution Logic

You can override the resolution logic by modifying `StrategyResolver#resolve` to use different selection criteria (e.g., priority-based selection, multiple strategy selection, etc.).

