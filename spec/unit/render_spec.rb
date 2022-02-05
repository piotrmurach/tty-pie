# frozen_string_literal: true

RSpec.describe TTY::Pie, "#render" do
  let(:data) {
    [
      { name: "BTC", value: 5977 },
      { name: "BCH", value: 3045 },
      { name: "LTC", value: 2030 }
    ]
  }

  it "renders chart with no data" do
    pie = TTY::Pie.new(data: [], radius: 2)

    expect(pie.render).to eq("")
  end

  it "renders an empty pie chart when all values are zero" do
    data = [
      {name: "BTC", value: 0},
      {name: "BCH", value: 0},
      {name: "LTC", value: 0}
    ]
    pie = TTY::Pie.new(data: data, radius: 2)

    expect(pie.render).to eq([
      "             • BTC 0.00%\n",
      "        \n",
      "             • BCH 0.00%\n",
      "        \n",
      "             • LTC 0.00%\n"
    ].join)
  end

  it "renders a pie chart with legend and without cursor positioning" do
    pie = TTY::Pie.new(data: data, radius: 2)

    output = pie.render

    expect(output).to eq([
       "   •••       • BTC 54.08%\n",
       " •••••••\n",
       "•••••••••    • BCH 27.55%\n",
       " •••••••\n",
       "   •••       • LTC 18.37%\n"
    ].join)
  end

  it "renders a pie chart without legend and without cursor positioning" do
    pie = TTY::Pie.new(data: data, radius: 2, legend: false)

    output = pie.render

    expect(output).to eq([
       "   •••\n",
       " •••••••\n",
       "•••••••••\n",
       " •••••••\n",
       "   •••\n"
    ].join)
  end

  it "renders a pie chart with legend and cursor positioning" do
    pie = TTY::Pie.new(data: data, radius: 2, left: 50, top: 10)

    output = pie.render

    expect(output).to eq([
      "\e[11;54H•\e[11;55H•\e[11;56H•\e[11;63H• BTC 54.08%\n",
      "\e[12;52H•\e[12;53H•\e[12;54H•\e[12;55H•\e[12;56H•\e[12;57H•\e[12;58H•\e[12;63H\n",
      "\e[13;51H•\e[13;52H•\e[13;53H•\e[13;54H•\e[13;55H•\e[13;56H•\e[13;57H•\e[13;58H•\e[13;59H•\e[13;63H• BCH 27.55%\n",
      "\e[14;52H•\e[14;53H•\e[14;54H•\e[14;55H•\e[14;56H•\e[14;57H•\e[14;58H•\e[14;63H\n",
      "\e[15;54H•\e[15;55H•\e[15;56H•",
      "\e[15;63H• LTC 18.37%\n"
    ].join)
  end

  it "renders a pie chart without legend and with cursor positioning" do
    pie = TTY::Pie.new(data: data, radius: 2, left: 50, top: 10, legend: false)

    output = pie.render

    expect(output).to eq([
      "\e[11;54H•\e[11;55H•\e[11;56H•\n",
      "\e[12;52H•\e[12;53H•\e[12;54H•\e[12;55H•\e[12;56H•\e[12;57H•\e[12;58H•\n",
      "\e[13;51H•\e[13;52H•\e[13;53H•\e[13;54H•\e[13;55H•\e[13;56H•\e[13;57H•\e[13;58H•\e[13;59H•\n",
      "\e[14;52H•\e[14;53H•\e[14;54H•\e[14;55H•\e[14;56H•\e[14;57H•\e[14;58H•\n",
      "\e[15;54H•\e[15;55H•\e[15;56H•\n",
    ].join)
  end
end
