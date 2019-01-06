# frozen_string_literal: true

RSpec.describe TTY::Pie, ':fill option' do
  let(:data) {
    [
      { name: 'BTC', value: 5977, color: :bright_yellow, fill: '*' },
      { name: 'BCH', value: 3045, color: :bright_green, fill: '+' },
      { name: 'LTC', value: 2030, color: :bright_magenta, fill: 'x' }
    ]
  }

  it "renders a pie chart with custom fill per data item" do
     pie = TTY::Pie.new(data: data, radius: 2)

     output = pie.render

     expect(output).to eq([
        "   \e[95mx\e[0m\e[93m*\e[0m\e[93m*\e[0m",
        "       \e[93m*\e[0m BTC 54.08%\n",
        " \e[92m+\e[0m\e[95mx\e[0m\e[95mx\e[0m\e[93m*\e[0m\e[93m*\e[0m\e[93m*\e[0m\e[93m*\e[0m\n\e[92m+\e[0m\e[92m+\e[0m\e[92m+\e[0m\e[92m+\e[0m\e[93m*\e[0m\e[93m*\e[0m\e[93m*\e[0m\e[93m*\e[0m\e[93m*\e[0m",
        "    \e[92m+\e[0m BCH 27.55%\n",
        " \e[92m+\e[0m\e[92m+\e[0m\e[92m+\e[0m\e[93m*\e[0m\e[93m*\e[0m\e[93m*\e[0m\e[93m*\e[0m\n",
        "   \e[92m+\e[0m\e[93m*\e[0m\e[93m*\e[0m",
        "       \e[95mx\e[0m LTC 18.37%\n"
     ].join)
  end

  it "renders with custom fill chars per instance" do
     data_without_fill = data.map { |item| item.delete(:fill); item }
     pie = TTY::Pie.new(data: data_without_fill, radius: 2, fill: %w[* + x])

     output = pie.render

     expected_output = [
        "   \e[95mx\e[0m\e[93m*\e[0m\e[93m*\e[0m",
        "       \e[93m*\e[0m BTC 54.08%\n",
        " \e[92m+\e[0m\e[95mx\e[0m\e[95mx\e[0m\e[93m*\e[0m\e[93m*\e[0m\e[93m*\e[0m\e[93m*\e[0m\n\e[92m+\e[0m\e[92m+\e[0m\e[92m+\e[0m\e[92m+\e[0m\e[93m*\e[0m\e[93m*\e[0m\e[93m*\e[0m\e[93m*\e[0m\e[93m*\e[0m",
        "    \e[92m+\e[0m BCH 27.55%\n",
        " \e[92m+\e[0m\e[92m+\e[0m\e[92m+\e[0m\e[93m*\e[0m\e[93m*\e[0m\e[93m*\e[0m\e[93m*\e[0m\n",
        "   \e[92m+\e[0m\e[93m*\e[0m\e[93m*\e[0m",
        "       \e[95mx\e[0m LTC 18.37%\n"

     ].join

     expect(output).to eq(expected_output)
  end
end
