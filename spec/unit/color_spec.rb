# frozen_string_literal: true

RSpec.describe TTY::PieChart, ':color option' do
  it "draws a pie chart without colors" do
    data = [
      { name: 'BTC', value: 5977, fill: '*' },
      { name: 'BCH', value: 3045, fill: '+' },
      { name: 'LTC', value: 2030, fill: 'x' }
    ]
    pie = TTY::PieChart.new(data, radius: 2)

    output = pie.draw

    expect(output).to eq([
      "   x**       * BTC 54.08%\n",
      " +xx****\n",
      "++++*****    + BCH 27.55%\n",
      " +++****\n",
      "   +**       x LTC 18.37%\n"
    ].join)
  end
end
