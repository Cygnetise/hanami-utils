# frozen_string_literal: true

require "rspec"
require "hanami/cyg_utils/io"

RSpec.configure do |config|
  config.around(:example, silence_deprecations: true) do |example|
    Hanami::CygUtils::IO.silence_warnings do
      example.run
    end
  end
end
