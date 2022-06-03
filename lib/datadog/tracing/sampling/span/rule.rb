module Datadog
  module Tracing
    module Sampling
      module Span
        # Span sampling rule that applies a sampling rate if the span
        # matches the provided {Matcher}.
        # Additionally, a rate limiter is also applied.
        #
        # If a span does not conform to the matcher, no changes are made.
        class Rule
          # Returns `true` if the provided span is sampled.
          # If the span is dropped due to sampling rate or rate limiting,
          # it returns `false`.
          #
          # Returns `nil` if the span did not meet the matching criteria by the
          # provided matcher.
          #
          # This method modifies the `span` if it matches the provided matcher.
          #
          # @param [Datadog::Tracing::SpanOperation] span
          # @return [Boolean] should this span be sampled?
          # @return [nil] span did not satisfy the matcher, no changes were made
          def sample!(span)
          end
        end
      end
    end
  end
end
