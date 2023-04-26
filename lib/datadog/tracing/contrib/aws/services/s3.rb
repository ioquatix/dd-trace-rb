# frozen_string_literal: true

require_relative '../ext'

def add_s3_tags(span, params)
  bucket_name = params[:bucket]
  span.set_tag(Datadog::Tracing::Contrib::Aws::Ext::TAG_BUCKET_NAME, bucket_name)
end
