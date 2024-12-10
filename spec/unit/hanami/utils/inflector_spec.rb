# frozen_string_literal: true

require "hanami/cyg_utils/inflector"
require "hanami/cyg_utils/string"

RSpec.describe Hanami::CygUtils::Inflector do
  describe ".inflections" do
    it "adds exception for singular rule" do
      actual = Hanami::CygUtils::Inflector.singularize("analyses") # see spec/support/fixtures.rb
      expect(actual).to eq "analysis"

      actual = Hanami::CygUtils::Inflector.singularize("algae") # see spec/support/fixtures.rb
      expect(actual).to eq "alga"
    end

    it "adds exception for plural rule" do
      actual = Hanami::CygUtils::Inflector.pluralize("analysis") # see spec/support/fixtures.rb
      expect(actual).to eq "analyses"

      actual = Hanami::CygUtils::Inflector.pluralize("alga") # see spec/support/fixtures.rb
      expect(actual).to eq "algae"
    end

    it "adds exception for uncountable rule" do
      actual = Hanami::CygUtils::Inflector.pluralize("music") # see spec/support/fixtures.rb
      expect(actual).to eq "music"

      actual = Hanami::CygUtils::Inflector.singularize("music") # see spec/support/fixtures.rb
      expect(actual).to eq "music"

      actual = Hanami::CygUtils::Inflector.pluralize("butter") # see spec/support/fixtures.rb
      expect(actual).to eq "butter"

      actual = Hanami::CygUtils::Inflector.singularize("butter") # see spec/support/fixtures.rb
      expect(actual).to eq "butter"
    end
  end

  describe ".pluralize" do
    it "returns nil when nil is given" do
      actual = Hanami::CygUtils::Inflector.pluralize(nil)
      expect(actual).to be_nil
    end

    it "returns empty string when empty string is given" do
      actual = Hanami::CygUtils::Inflector.pluralize("")
      expect(actual).to be_empty
    end

    it "returns empty string when empty string is given (multiple chars)" do
      actual = Hanami::CygUtils::Inflector.pluralize(string = "   ")
      expect(actual).to eq string
    end

    it "returns instance of String" do
      result = Hanami::CygUtils::Inflector.pluralize("Hanami")
      expect(result.class).to eq ::String
    end

    it "doesn't modify original string" do
      string = "application"
      result = Hanami::CygUtils::Inflector.pluralize(string)

      expect(result.object_id).not_to eq(string.object_id)
      expect(string).to eq("application")
    end

    TEST_PLURALS.each do |singular, plural|
      it %(pluralizes "#{singular}" to "#{plural}") do
        actual = Hanami::CygUtils::Inflector.pluralize(singular)
        expect(actual).to eq plural
      end

      it %(pluralizes titleized "#{Hanami::CygUtils::String.titleize(singular)}" to "#{plural}"), silence_deprecations: true do
        skip if RUBY_VERSION >= "3.0"

        actual = Hanami::CygUtils::Inflector.pluralize(Hanami::CygUtils::String.new(singular).titleize)
        expect(actual).to eq Hanami::CygUtils::String.new(plural).titleize
      end

      #     it %(doesn't pluralize "#{ plural }" as it's already plural) do
      #       actual = Hanami::CygUtils::Inflector.pluralize(plural)
      #       expect(actual).to eq plural
      #     end

      #     it %(doesn't pluralize titleized "#{ Hanami::CygUtils::String.new(singular).titleize }" as it's already plural) do
      #       actual = Hanami::CygUtils::Inflector.pluralize(Hanami::CygUtils::String.new(plural).titleize)
      #       expect(actual).to eq Hanami::CygUtils::String.new(plural).titleize
      #     end
    end
  end

  describe ".singularize" do
    it "returns nil when nil is given" do
      actual = Hanami::CygUtils::Inflector.singularize(nil)
      expect(actual).to be_nil
    end

    it "returns empty string when empty string is given" do
      actual = Hanami::CygUtils::Inflector.singularize("")
      expect(actual).to be_empty
    end

    it "returns empty string when empty string is given (multiple chars)" do
      actual = Hanami::CygUtils::Inflector.singularize(string = "   ")
      expect(actual).to eq string
    end

    it "returns instance of String" do
      result = Hanami::CygUtils::Inflector.singularize("application")
      expect(result.class).to eq ::String
    end

    it "doesn't modify original string" do
      string = "applications"
      result = Hanami::CygUtils::Inflector.singularize(string)

      expect(result.object_id).not_to eq(string.object_id)
      expect(string).to eq("applications")
    end

    TEST_SINGULARS.each do |singular, plural|
      it %(singularizes "#{plural}" to "#{singular}") do
        actual = Hanami::CygUtils::Inflector.singularize(plural)
        expect(actual).to eq singular
      end

      it %(singularizes titleized "#{Hanami::CygUtils::String.titleize(plural)}" to "#{singular}"), silence_deprecations: true do
        skip if RUBY_VERSION >= "3.0"

        actual = Hanami::CygUtils::Inflector.singularize(Hanami::CygUtils::String.new(plural).titleize)
        expect(actual).to eq Hanami::CygUtils::String.new(singular).titleize
      end

      # it %(doesn't singularizes "#{ singular }" as it's already singular) do
      #   actual = Hanami::CygUtils::Inflector.singularize(singular)
      #   expect(actual).to eq singular
      # end

      # it %(doesn't singularizes titleized "#{ Hanami::CygUtils::String.new(plural).titleize }" as it's already singular) do
      #   actual = Hanami::CygUtils::Inflector.singularize(Hanami::CygUtils::String.new(singular).titleize)
      #   expect(actual).to Hanami::CygUtils::String.new(singular).titleize
      # end
    end
  end
end
