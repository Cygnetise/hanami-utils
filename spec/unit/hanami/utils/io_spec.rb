# frozen_string_literal: true

require "hanami/cyg_utils/io"

class IOTest
  TEST_CONSTANT = "initial"
end

RSpec.describe Hanami::CygUtils::IO do
  describe ".silence_warnings" do
    it "lowers verbosity of stdout" do
      expect do
        Hanami::CygUtils::IO.silence_warnings do
          IOTest::TEST_CONSTANT = "redefined"
        end
      end.to output(eq("")).to_stderr
    end
  end
end
