# frozen_string_literal: true

require "hanami/cyg_utils/kernel"
require "hanami/cyg_utils/string"
require "hanami/cyg_utils/hash"
require "hanami/cyg_utils/blank"

RSpec.describe Hanami::CygUtils::Blank do
  describe ".blank?" do
    [nil, false, "", "   ", "  \n\t  \r ", "　", "\u00a0", [], {}, Set.new,
     Hanami::CygUtils::Kernel.Boolean(0), Hanami::CygUtils::String.new(""),
     Hanami::CygUtils::Hash.new({})].each do |v|
       it "returns true", silence_deprecations: true do
         expect(Hanami::CygUtils::Blank.blank?(v)).to eq(true)
       end
     end

    [Object.new, true, 0, 1, "a", :book, DateTime.now, Time.now, Date.new, [nil], {nil => 0}, Set.new([1]),
     Hanami::CygUtils::Kernel.Symbol(:hello), Hanami::CygUtils::String.new("foo"),
     Hanami::CygUtils::Hash.new(foo: :bar)].each do |v|
       it "returns false", silence_deprecations: true do
         expect(Hanami::CygUtils::Blank.blank?(v)).to eq(false)
       end
     end
  end

  describe ".filled?" do
    [nil, false, "", "   ", "  \n\t  \r ", "　", "\u00a0", [], {}, Set.new,
     Hanami::CygUtils::Kernel.Boolean(0), Hanami::CygUtils::String.new(""),
     Hanami::CygUtils::Hash.new({})].each do |v|
       it "returns false", silence_deprecations: true do
         expect(Hanami::CygUtils::Blank.filled?(v)).to eq(false)
       end
     end

    [Object.new, true, 0, 1, "a", :book, DateTime.now, Time.now, Date.new, [nil], {nil => 0}, Set.new([1]),
     Hanami::CygUtils::Kernel.Symbol(:hello), Hanami::CygUtils::String.new("foo"),
     Hanami::CygUtils::Hash.new(foo: :bar)].each do |v|
       it "returns true", silence_deprecations: true do
         expect(Hanami::CygUtils::Blank.filled?(v)).to eq(true)
       end
     end
  end
end
