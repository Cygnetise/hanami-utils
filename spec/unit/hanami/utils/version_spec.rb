# frozen_string_literal: true

RSpec.describe "Hanami::CygUtils::VERSION" do
  it "exposes version" do
    expect(Hanami::CygUtils::VERSION).to eq("1.3.8")
  end
end
