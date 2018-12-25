# frozen_string_literal: true

RSpec.describe TTY::Pie, '#update' do
  it "updates current data" do
    data = [ { name: 'BTC', value: 5977, fill: '*' } ]

    pie = TTY::Pie.new(data: data, radius: 2)

    output = pie.draw

    expect(output).to eq([
      "   ***\n",
      " *******\n",
      "*********    * BTC 100.00%\n",
      " *******\n",
      "   ***\n"
    ].join)

    pie.update([{name: 'LTC', value: 2030, fill: 'x'}])

    output = pie.draw

    expect(output).to eq([
      "   xxx\n",
      " xxxxxxx\n",
      "xxxxxxxxx    x LTC 100.00%\n",
      " xxxxxxx\n",
      "   xxx\n"
    ].join)
  end
end
