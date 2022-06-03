# frozen_string_literal: true

module Datadog
  module Tracing
    module Sampling
      module Span
        # Checks if a span conforms to a matching criteria.
        class Ext
          TAG_MECHANISM = '_dd.span_sampling.mechanism'
          TAG_RULE_RATE = '_dd.span_sampling.rule_rate'
          TAG_LIMIT_RATE = '_dd.span_sampling.limit_rate'

          # Single span was sampled on account of a span sampling rule
          MECHANISM_SPAN_SAMPLING_RATE = 8
        end
      end
    end
  end
end
