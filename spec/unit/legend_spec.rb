# frozen_string_literal: true

RSpec.describe TTY::Pie, ':legend option' do
  it "renders legend at default location with 1 line separator" do
    data = [
      { name: 'BTC', value: 5977, fill: '*' },
      { name: 'BCH', value: 3045, fill: '+' },
      { name: 'LTC', value: 2030, fill: 'x' }
    ]

    pie = TTY::Pie.new(data: data, radius: 2)

    output = pie.render

    expect(output).to eq([
      "   x**       * BTC 54.08%\n",
      " +xx****\n",
      "++++*****    + BCH 27.55%\n",
      " +++****\n",
      "   +**       x LTC 18.37%\n"
    ].join)
  end

  it "renders legend next to chart without any line separator" do
    data = [
      { name: 'BTC', value: 5977, fill: '*' },
      { name: 'BCH', value: 3045, fill: '+' },
      { name: 'LTC', value: 2030, fill: 'x' }
    ]

    pie = TTY::Pie.new(data: data, radius: 2, legend: {left: 0, line: 0})

    output = pie.render

    expect(output).to eq([
      "   x**\n",
      " +xx**** * BTC 54.08%\n",
      "++++*****+ BCH 27.55%\n",
      " +++**** x LTC 18.37%\n",
      "   +**\n"
    ].join)
  end

  it "renders legend at custom location with line separator" do
    data = [
      { name: 'BTC', value: 5977, fill: '*' },
      { name: 'BCH', value: 3045, fill: '+' },
      { name: 'LTC', value: 2030, fill: 'x' }
    ]

    pie = TTY::Pie.new(data: data, radius: 3, legend: {left: 10, line: 2})

    output = pie.render

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

  it "renders legend with a custom format" do
    data = [
      { name: 'BTC', value: 5977, fill: '*' },
      { name: 'BCH', value: 3045, fill: '+' },
      { name: 'LTC', value: 2030, fill: 'x' }
    ]

    pie = TTY::Pie.new(
      data: data,
      radius: 2,
      legend: {
        format: "%<label>s %<name>s %<value>d (%<percent>.2f%%)"
      }
    )

    output = pie.render

    expect(output).to eq([
      "   x**       * BTC 5977 (54.08%)\n",
      " +xx****\n",
      "++++*****    + BCH 3045 (27.55%)\n",
      " +++****\n",
      "   +**       x LTC 2030 (18.37%)\n"
    ].join)
  end

  it "renders legend with a custom format & value as currency" do
    data = [
      { name: 'BTC', value: 5977.12345, fill: '*' },
      { name: 'BCH', value: 3045.2, fill: '+' },
      { name: 'LTC', value: 2030.444, fill: 'x' }
    ]

    pie = TTY::Pie.new(
      data: data,
      radius: 2,
      legend: {
        format: "%<label>s %<name>s $%<currency>s (%<percent>.0f%%)"
      }
    )

    output = pie.render

    expect(output).to eq([
      "   x**       * BTC $5,977.12 (54%)\n",
      " +xx****\n",
      "++++*****    + BCH $3,045.20 (28%)\n",
      " +++****\n",
      "   +**       x LTC $2,030.44 (18%)\n"
    ].join)
  end

  it "renders legend with a custom format and currency precision & delimiter" do
    data = [
      { name: 'BTC', value: 5977.12345, fill: '*' },
      { name: 'BCH', value: 3045.2, fill: '+' },
      { name: 'LTC', value: 2030.444, fill: 'x' }
    ]

    pie = TTY::Pie.new(
      data: data,
      radius: 2,
      legend: {
        format: "%<label>s %<name>s $%<currency>s (%<percent>.0f%%)",
        precision: 3,
        delimiter: '*'
      }
    )

    output = pie.render

    expect(output).to eq([
      "   x**       * BTC $5*977.123 (54%)\n",
      " +xx****\n",
      "++++*****    + BCH $3*045.200 (28%)\n",
      " +++****\n",
      "   +**       x LTC $2*030.444 (18%)\n"
    ].join)
  end
end
