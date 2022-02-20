# frozen_string_literal: true

require "rspec-benchmark"
require "yaml"

RSpec.describe TTY::Pie do
  include RSpec::Benchmark::Matchers

  let(:data) {
    [
      {name: "BTC", value: 5977},
      {name: "BCH", value: 3045},
      {name: "LTC", value: 2030}
    ]
  }

  it "performs pie chart rendering slower than YAML generator" do
    pie = described_class.new(data: data)

    expect {
      pie.render
    }.to perform_slower_than {
      YAML.dump(data)
    }.at_most(4).times
  end

  it "performs pie chart rendering at 1k i/s" do
    pie = described_class.new(data: data)

    expect {
      pie.render
    }.to perform_at_least(1000).ips
  end

  it "renders pie chart allocating no more than 193 objects" do
    pie = described_class.new(data: data)

    expect {
      pie.render
    }.to perform_allocation(193).objects
  end
end
