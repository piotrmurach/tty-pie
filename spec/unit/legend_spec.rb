# frozen_string_literal: true

RSpec.describe TTY::PieChart, ':legend option' do
  it "draws legend at default location with 1 line separator" do
    data = [
      { name: 'BTC', value: 5977, fill: '*' },
      { name: 'BCH', value: 3045, fill: '+' },
      { name: 'LTC', value: 2030, fill: 'x' }
    ]

    pie = TTY::PieChart.new(data: data, radius: 2)

    output = pie.draw

    expect(output).to eq([
      "   x**       * BTC 54.08%\n",
      " +xx****\n",
      "++++*****    + BCH 27.55%\n",
      " +++****\n",
      "   +**       x LTC 18.37%\n"
    ].join)
  end

  it "draws legend next to chart without any line separator" do
    data = [
      { name: 'BTC', value: 5977, fill: '*' },
      { name: 'BCH', value: 3045, fill: '+' },
      { name: 'LTC', value: 2030, fill: 'x' }
    ]

    pie = TTY::PieChart.new(data: data, radius: 2, legend: {left: 0, line: 0})

    output = pie.draw

    expect(output).to eq([
      "   x**\n",
      " +xx**** * BTC 54.08%\n",
      "++++*****+ BCH 27.55%\n",
      " +++**** x LTC 18.37%\n",
      "   +**\n"
    ].join)
  end

  it "draws legend at custom location with line separator" do
    data = [
      { name: 'BTC', value: 5977, fill: '*' },
      { name: 'BCH', value: 3045, fill: '+' },
      { name: 'LTC', value: 2030, fill: 'x' }
    ]

    pie = TTY::PieChart.new(data: data, radius: 3, legend: {left: 10, line: 2})

    output = pie.draw

    expect(output).to eq([
      "     x**               * BTC 54.08%\n",
      "  xxxx*****\n",
      "++++xx*******\n",
      "++++++*******          + BCH 27.55%\n",
      "++++++*******\n",
      "  ++++*****\n",
      "     +**               x LTC 18.37%\n"
    ].join)
  end
end
