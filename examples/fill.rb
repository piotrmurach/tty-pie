require_relative '../lib/tty-pie_chart'

data = [
  { name: 'BTC', value: 5977, color: :bright_yellow, fill: '*' },
  { name: 'BCH', value: 3045, color: :bright_green, fill: 'x' },
  { name: 'LTC', value: 2030, color: :bright_magenta, fill: '@' },
  { name: 'ETH', value: 2350, color: :bright_cyan, fill: '+' }
]

pie = TTY::PieChart.new(data: data, radius: 10)

puts pie.draw
