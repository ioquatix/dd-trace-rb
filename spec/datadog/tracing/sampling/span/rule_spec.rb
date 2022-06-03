require 'datadog/tracing/sampling/span/matcher'
require 'datadog/tracing/sampling/span/rule'

RSpec.describe Datadog::Tracing::Sampling::Span::Rule do
  subject(:rule) { described_class.new(matcher, sampling_rate, rate_limit) }
  let(:matcher) { instance_double(Datadog::Tracing::Sampling::Span::Matcher) }
  let(:sampling_rate) { 0.0 }
  let(:rate_limit) { 0 }

  let(:span_op) { Datadog::Tracing::SpanOperation.new(span_name, service: span_service) }
  let(:span_name) { 'operation.name' }
  let(:span_service) { '' }

  describe '#sample!' do
    subject(:sample!) { rule.sample!(span_op) }

    context 'when matching' do
      before do
        expect(matcher).to receive(:match?).with(span_op).and_return(true)
      end

      context 'not sampled' do
        it 'returns false' do
          is_expected.to eq(false)
        end

        it 'not modify span' do
          expect { sample! }.to_not change{ span_op.send(:build_span) }
        end
      end
    end

    context 'when not matching' do
      before do
        expect(matcher).to receive(:match?).with(span_op).and_return(false)
      end

      it 'returns nil' do
        is_expected.to be_nil
      end

      it 'not modify span' do
        expect { sample! }.to_not change{ span_op.send(:build_span) }
      end
    end

    # context "with pattern '#{pattern}' and input '#{input}'" do
    #   context 'matching on span name' do
    #     let(:matcher) { described_class.new(name_pattern: pattern) }
    #     let(:span_name) { input }
    #
    #     it "does #{'not ' unless expected}match" do
    #       is_expected.to eq(expected)
    #     end
    #   end
    #
    #   context 'matching on span service' do
    #     let(:matcher) { described_class.new(service_pattern: pattern) }
    #     let(:span_service) { input }
    #
    #     it "does #{'not ' unless expected}match" do
    #       is_expected.to eq(expected)
    #     end
    #   end
    #
    #   context 'matching on span name and service' do
    #     context 'with the same matching scenario for both fields' do
    #       let(:matcher) { described_class.new(name_pattern: pattern, service_pattern: pattern) }
    #       let(:span_name) { input }
    #       let(:span_service) { input }
    #
    #       it "does #{'not ' unless expected}match" do
    #         is_expected.to eq(expected)
    #       end
    #     end
    #   end
    # end
    #
    # context 'matching on span name and service' do
    #   let(:matcher) { described_class.new(name_pattern: name_pattern, service_pattern: service_pattern) }
    #
    #   context 'when only name matches' do
    #     let(:span_name) { 'web.get' }
    #     let(:span_service) { 'server' }
    #     let(:name_pattern) { 'web.*' }
    #     let(:service_pattern) { 'server2' }
    #
    #     context 'does not match' do
    #       it { is_expected.to eq(false) }
    #     end
    #   end
    #
    #   context 'when only service matches' do
    #     let(:span_name) { 'web.get' }
    #     let(:span_service) { 'server' }
    #     let(:name_pattern) { 'web.post' }
    #     let(:service_pattern) { 'server' }
    #
    #     context 'does not match' do
    #       it { is_expected.to eq(false) }
    #     end
    #   end
    # end
  end
end
