# frozen_string_literal: true

require_relative __dir__ + "../../../../../support/isolation_spec_helper"
Bundler.require(:default, :development, :multi_json)

require "gson" if Hanami::Utils.jruby?
require "hanami/cyg_utils/json"

RSpec.describe Hanami::CygUtils::Json do
  describe "with MultiJson" do
    it "uses MultiJson engine" do
      expect(Hanami::CygUtils::Json.class_variable_get(:@@engine)).to be_kind_of(Hanami::CygUtils::Json::MultiJsonAdapter)
    end

    describe ".parse" do
      it "loads given payload" do
        actual = Hanami::CygUtils::Json.parse %({"a":1})
        expect(actual).to eq("a" => 1)
      end

      it "raises error if given payload is malformed" do
        expect { Hanami::CygUtils::Json.parse %({"a:1}) }.to raise_error(Hanami::CygUtils::Json::ParserError)
      end

      # See: https://github.com/hanami/cyg_utils/issues/169
      it "doesn't eval payload" do
        actual = Hanami::CygUtils::Json.parse %({"json_class": "Foo"})
        expect(actual).to eq("json_class" => "Foo")
      end
    end

    describe ".generate" do
      it "dumps given Hash" do
        actual = Hanami::CygUtils::Json.generate(a: 1)
        expect(actual).to eq %({"a":1})
      end
    end
  end
end

RSpec::Support::Runner.run
