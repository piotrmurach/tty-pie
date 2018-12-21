require_relative '../lib/tty-pie'

data = [
  { name: 'BTC', value: 5977, color: :bright_yellow },
  { name: 'BCH', value: 3045, color: :bright_green },
  { name: 'LTC', value: 2030, color: :bright_magenta },
  { name: 'ETH', value: 2350, color: :bright_cyan }
]

pie = TTY::Pie.new(data: data, radius: 10)

puts pie
