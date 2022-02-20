# frozen_string_literal: true

RSpec.describe TTY::Pie, "#reset" do
  it "resets current data" do
    data = [{name: "BTC", value: 5977, fill: "*"}]

    pie = TTY::Pie.new(data: data, radius: 2)

    output = pie.render

    expect(output).to eq([
      "   ***\n",
      " *******\n",
      "*********    * BTC 100.00%\n",
      " *******\n",
      "   ***\n"
    ].join)

    pie.reset

    expect(pie.render).to eq("")
  end
end
