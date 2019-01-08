require_relative '../lib/tty-pie'

data = [
  { name: 'BTC', value: 5977, color: :yellow },
  { name: 'BCH', value: 3045, color: :green },
  { name: 'LTC', value: 2030, color: :magenta },
]

pie = TTY::Pie.new(
  data: data,
  legend: {
    format: "%<label>s %<name>s $%<currency>s (%<percent>.0f%%)"
  }
)

puts pie
