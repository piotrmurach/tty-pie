# frozen_string_literal: true

RSpec.describe TTY::PieChart, '#draw' do
  let(:data) {
    [
      { name: 'BTC', value: 5977, color: :bright_yellow },
      { name: 'BCH', value: 3045, color: :bright_green },
      { name: 'LTC', value: 2030, color: :bright_magenta }
    ]
  }

  it "draws a pie chart with legend and without cursor positioning" do
    pie = TTY::PieChart.new(data, radius: 2)

    output = pie.draw

    expect(output).to eq([
       "   \e[95m•\e[0m\e[93m•\e[0m\e[93m•\e[0m",
       "       \e[93m•\e[0m BTC 54.08%\n",
       " \e[92m•\e[0m\e[95m•\e[0m\e[95m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\n",
       "\e[92m•\e[0m\e[92m•\e[0m\e[92m•\e[0m\e[92m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\e[93m•\e[0m",
       "    \e[92m•\e[0m BCH 27.55%\n",
       " \e[92m•\e[0m\e[92m•\e[0m\e[92m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\n",
       "   \e[92m•\e[0m\e[93m•\e[0m\e[93m•\e[0m",
       "       \e[95m•\e[0m LTC 18.37%\n"
    ].join)
  end

  it "draws a pie chart without legend and without cursor positioning" do
    pie = TTY::PieChart.new(data, radius: 2, legend: false)

    output = pie.draw

    expect(output).to eq([
       "   \e[95m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\n",
       " \e[92m•\e[0m\e[95m•\e[0m\e[95m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\n",
       "\e[92m•\e[0m\e[92m•\e[0m\e[92m•\e[0m\e[92m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\n",
       " \e[92m•\e[0m\e[92m•\e[0m\e[92m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\n",
       "   \e[92m•\e[0m\e[93m•\e[0m\e[93m•\e[0m\n",
    ].join)
  end

  it "draw a pie chart with legend and cursor positioning" do
    pie = TTY::PieChart.new(data, radius: 2, left: 50, top: 10)

    output = pie.draw

    expect(output).to eq([
      "\e[11;54H\e[95m•\e[0m\e[11;55H\e[93m•\e[0m\e[11;56H\e[93m•\e[0m",
      "\e[11;63H\e[93m•\e[0m BTC 54.08%\n",
      "\e[12;52H\e[92m•\e[0m\e[12;53H\e[95m•\e[0m\e[12;54H\e[95m•\e[0m\e[12;55H\e[93m•\e[0m\e[12;56H\e[93m•\e[0m\e[12;57H\e[93m•\e[0m\e[12;58H\e[93m•\e[0m\e[12;63H\n",
      "\e[13;51H\e[92m•\e[0m\e[13;52H\e[92m•\e[0m\e[13;53H\e[92m•\e[0m\e[13;54H\e[92m•\e[0m\e[13;55H\e[93m•\e[0m\e[13;56H\e[93m•\e[0m\e[13;57H\e[93m•\e[0m\e[13;58H\e[93m•\e[0m\e[13;59H\e[93m•\e[0m",
      "\e[13;63H\e[92m•\e[0m BCH 27.55%\n",
      "\e[14;52H\e[92m•\e[0m\e[14;53H\e[92m•\e[0m\e[14;54H\e[92m•\e[0m\e[14;55H\e[93m•\e[0m\e[14;56H\e[93m•\e[0m\e[14;57H\e[93m•\e[0m\e[14;58H\e[93m•\e[0m\e[14;63H\n",
      "\e[15;54H\e[92m•\e[0m\e[15;55H\e[93m•\e[0m\e[15;56H\e[93m•\e[0m",
      "\e[15;63H\e[95m•\e[0m LTC 18.37%\n"
    ].join)
  end

  it "draw a pie chart without legend and with cursor positioning" do
    pie = TTY::PieChart.new(data, radius: 2, left: 50, top: 10, legend: false)

    output = pie.draw

    expect(output).to eq([
      "\e[11;54H\e[95m•\e[0m\e[11;55H\e[93m•\e[0m\e[11;56H\e[93m•\e[0m\n",
      "\e[12;52H\e[92m•\e[0m\e[12;53H\e[95m•\e[0m\e[12;54H\e[95m•\e[0m\e[12;55H\e[93m•\e[0m\e[12;56H\e[93m•\e[0m\e[12;57H\e[93m•\e[0m\e[12;58H\e[93m•\e[0m\n",
      "\e[13;51H\e[92m•\e[0m\e[13;52H\e[92m•\e[0m\e[13;53H\e[92m•\e[0m\e[13;54H\e[92m•\e[0m\e[13;55H\e[93m•\e[0m\e[13;56H\e[93m•\e[0m\e[13;57H\e[93m•\e[0m\e[13;58H\e[93m•\e[0m\e[13;59H\e[93m•\e[0m\n",
      "\e[14;52H\e[92m•\e[0m\e[14;53H\e[92m•\e[0m\e[14;54H\e[92m•\e[0m\e[14;55H\e[93m•\e[0m\e[14;56H\e[93m•\e[0m\e[14;57H\e[93m•\e[0m\e[14;58H\e[93m•\e[0m\n",
      "\e[15;54H\e[92m•\e[0m\e[15;55H\e[93m•\e[0m\e[15;56H\e[93m•\e[0m\n",
    ].join)
  end
end
