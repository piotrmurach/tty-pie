# frozen_string_literal: true

RSpec.describe TTY::PieChart, '#add' do
  it "adds additional item" do
    data = [ { name: 'BTC', value: 5977, fill: '*' } ]

    pie = TTY::PieChart.new(data, radius: 2)
    pie << { name: 'BCH', value: 3045, fill: '+' }
    pie << { name: 'LTC', value: 2030, fill: 'x' }

    output = pie.draw

    expect(output).to eq([
      "   x**       * BTC 54.08%\n",
      " +xx****\n",
      "++++*****    + BCH 27.55%\n",
      " +++****\n",
      "   +**       x LTC 18.37%\n"
    ].join)
  end

  it "adds item without modifying original data source" do
    data = [ { name: 'BTC', value: 5977, fill: '*' } ]
    pie = TTY::PieChart.new(data, radius: 2)
    pie << { name: 'BCH', value: 3045, fill: '+' }

    puts "DATA: #{data.inspect}"

    expect(data).to match([a_hash_including(name: 'BTC')])
  end
end
