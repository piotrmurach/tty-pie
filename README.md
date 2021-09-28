<div align="center">
  <a href="https://piotrmurach.github.io/tty" target="_blank"><img width="130" src="https://github.com/piotrmurach/tty/raw/master/images/tty.png" alt="tty logo" /></a>
</div>

# TTY:Pie [![Gitter](https://badges.gitter.im/Join%20Chat.svg)][gitter]

[![Gem Version](https://badge.fury.io/rb/tty-pie.svg)][gem]
[![Actions CI](https://github.com/piotrmurach/tty-pie/workflows/CI/badge.svg?branch=master)][gh_actions_ci]
[![Build status](https://ci.appveyor.com/api/projects/status/9n69xpw64sylqh2y?svg=true)][appveyor]
[![Maintainability](https://api.codeclimate.com/v1/badges/dfac05073e1549e9dbb6/maintainability)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/github/piotrmurach/tty-pie/badge.svg)][coverage]
[![Inline docs](https://inch-ci.org/github/piotrmurach/tty-pie.svg?branch=master)][inchpages]

[gitter]: https://gitter.im/piotrmurach/tty
[gem]: https://badge.fury.io/rb/tty-pie
[gh_actions_ci]: https://github.com/piotrmurach/tty-pie/actions?query=workflow%3ACI
[appveyor]: https://ci.appveyor.com/project/piotrmurach/tty-pie
[codeclimate]: https://codeclimate.com/github/piotrmurach/tty-pie/maintainability
[coverage]: https://coveralls.io/github/piotrmurach/tty-pie
[inchpages]: https://inch-ci.org/github/piotrmurach/tty-pie

> Draw pie charts in your terminal window

**TTY::Pie** provides pie chart drawing component for [TTY](https://github.com/piotrmurach/tty) toolkit.

![Pie chart drawing](https://github.com/piotrmurach/tty-pie/blob/master/assets/tty-pie_chart_drawing_crypto.png)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "tty-pie"
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tty-pie

## Contents

* [1. Usage](#1-usage)
* [2. Interface](#2-interface)
  * [2.1 data](#21-data)
  * [2.2 add](#22-add)
  * [2.3 update](#23-update)
  * [2.4 render](#24-render)
  * [2.5 position](#25-position)
  * [2.6 radius](#26-radius)
  * [2.7 legend](#27-legend)
    * [2.7.1 format](#271-format)

## 1. Usage

To render a pie chart you need to provide an array of data items:

```ruby
data = [
  { name: "BTC", value: 5977, color: :bright_yellow, fill: "*" },
  { name: "BCH", value: 3045, color: :bright_green, fill: "x" },
  { name: "LTC", value: 2030, color: :bright_magenta, fill: "@" },
  { name: "ETH", value: 2350, color: :bright_cyan, fill: "+" }
]
```

Then pass data to **TTY::Pie** instance with a given radius:

```ruby
pie_chart = TTY::Pie.new(data: data, radius: 5)
```

and print the pie chart in your terminal window:

```ruby
print pie_chart
# =>
#         ++***
#     ++++++*******        * BTC 44.60%
#   @@@+++++*********
#  @@@@@@+++**********     x BCH 22.72%
# @@@@@@@@@+***********
# @@@@@@@@@@x**********    @ LTC 15.15%
# @@@@@@@@@xx**********
#  @@@@@@xxxx*********     + ETH 17.53%
#   @@@xxxxxxx*******
#     xxxxxxxx*****
#         xxxx*
# 
```

## 2. Interface

### 2.1 data

To render a pie chart you need to provide data. A single data item is just a Ruby hash that can contain the following keys:

* `:name` - used for setting the entry name in legend
* `:value` - used for calculating actual pie slice size
* `:color` - used to color a pie slice corresponding with a value
* `:fill` - used as a character to fill in a pie slice

At the very minimum you need to provide a `:value` in order for a pie to calculate slice sizes. If you wish to have a legend then add the `:name` key as well.

For example, the following will result in four slices in a pie chart:

```ruby
data = [
  { name: "BTC", value: 5977 },
  { name: "BCH", value: 3045 },
  { name: "LTC", value: 2030 },
  { name: "ETH", value: 2350 }
]
```

However, the above data slices will be displayed without any color. Use `:color` out of [supported colors](https://github.com/piotrmurach/pastel#3-supported-colors):

```ruby
data = [
  { name: "BTC", value: 5977, color: :bright_yellow },
  { name: "BCH", value: 3045, color: :bright_green },
  { name: "LTC", value: 2030, color: :bright_magenta },
  { name: "ETH", value: 2350, color: :bright_cyan }
]
```

To further make your chart readable consider making pie chart slices visible by channging the displayed characters using `:fill` key:

```ruby
data = [
  { name: "BTC", value: 5977, color: :bright_yellow, fill: "*" },
  { name: "BCH", value: 3045, color: :bright_green, fill: "x" },
  { name: "LTC", value: 2030, color: :bright_magenta, fill: "@" },
  { name: "ETH", value: 2350, color: :bright_cyan, fill: "+" }
]
```

There is no limit to the amount of data you can present, however there is a point of scale and legibility to be considered when printing in the terminals.

You can add data to pie chart during initialization using `:data` keyword:

```ruby
pie_chart = TTY::Pie.new(data: data)
```

Alternatively, you can delay adding data later with `add` or `<<` methods:

```ruby
pie_chart = TTY::Pie.new
pie_chart << { name: "BTC", value: 5977, color: :bright_yellow, fill: "*" }
pie_chart << { name: "BCH", value: 3045, color: :bright_green, fill: "x" }
pie_chart << { name: "LTC", value: 2030, color: :bright_magenta, fill: "@" }
pie_chart << { name: "ETH", value: 2350, color: :bright_cyan, fill: "+" }
```

### 2.2 add

You can also set data for the pie chart using the `add` or `<<` method calls. Once a pie chart is initialized, you can add data items:

```ruby
pie_chart = TTY::Pie.new
pie_chart << { name: "BTC", value: 5977, color: :bright_yellow, fill: "*" }
pie_chart << { name: "BCH", value: 3045, color: :bright_green, fill: "x" }
...
```

### 2.3 update

To replace current data completely with the new use `update`:

```ruby
data = [
  { name: "BTC", value: 5977, color: :bright_yellow, fill: "*" },
  { name: "BCH", value: 3045, color: :bright_green, fill: "x" }
]
pie_chart = TTY::Pie.new(data: data)

new_data = [
  { name: "BTC", value: 3400, color: :bright_yellow, fill: "*" },
  { name: "BCH", value: 1200, color: :bright_green, fill: "x" },
]

pie_chart.update(new_data)
```

### 2.4 render

Once a pie chart has been initialized use the `render` or `to_s` method to return a string representation of the chart.

To actually show it in a terminal, you need to print it:

```ruby
print pie_chart.render
# => this will render chart in terminal
```

You can skip calling any method and simply print:

```ruby
print pie_chart
# => this will render chart in terminal
```

### 2.5 position

If you don't provide location for you pie chart it will be printed at the current cursor location. In order to absolutely position the chart use `:left` and `:top` keyword arguments. For example, if you wanted to position the pie chart at `50th`column and `10th` row:

```ruby
TTY::Pie.new(data: data, left: 50, top: 10)
```

### 2.6 radius

By default, a pie chart is rendered with a radius of `10`, you can change this using the `:radius` keyword:

```ruby
TTY::Pie.new(data: data, radius: 5)
```

### 2.7 legend

Provided the following data:

```ruby
data = [
  { name: "BTC", value: 5977, fill: "*" },
  { name: "BCH", value: 3045, fill: "+" },
  { name: "LTC", value: 2030, fill: "x" }
]
```

You can control how the legend is displayed using the `:legend` keyword and hash as value with the following keys:

* `:left` - used to determine spacing between a chart and a legend, defaults to `4` columns
* `:line` - used to determine spacing between legend labels, defaults to `1` line
* `:format` - used to format a display label using template named strings
* `:precision` - used to determine currency display decimal places, defaults to `2`
* `:delimiter` - used to set thousands delimiter in currency format

For example, to place a legend `10` columns away from the pie chart and separate each label by `2` lines do:

```ruby
pie_chart = TTY::Pie.new(data: data, radius: 3, legend: {left: 10, line: 2})
```

And printing in a terminal will produce:

```ruby
print pie_chart
# =>
#      x**               * BTC 54.08%
#   xxxx*****
# ++++xx*******
# ++++++*******          + BCH 27.55%
# ++++++*******
#   ++++*****
#      +**               x LTC 18.37%
```

#### 2.7.1 format

The `:format` uses Ruby's [format sequences](https://ruby-doc.org/core-2.5.0/Kernel.html#method-i-format) and named strings placeholders:

* `<label>` - the icon matching pie chart display
* `<name>` - the label name provided in data
* `<value>` - the label value provided in data, by default not displayed
* `<currency>` - the label value formatted as currency
* `<percent>` - the percent automatically calculated from data

By default the label is formatted according to the following pattern with named strings:

```ruby
"%<label>s %<name>s %<percent>.2f%%"
```

Given data items:

```ruby
data = [
  { name: "BTC", value: 5977.12345, fill: "*" },
  { name: "BCH", value: 3045.2, fill: "+" },
  { name: "LTC", value: 2030.444, fill: "x" }
]
```

The legend will show:

```ruby
# =>
#      x**       * BTC 54.08%
#   xxxx*****
# ++++xx*******
# ++++++*******  + BCH 27.55%
# ++++++*******
#   ++++*****
#      +**       x LTC 18.37%
```

To display value together with percent, use `<value>` named string in the format:

```ruby
legend: {
  format: "%<label>s %<name>s %<value>d (%<percent>.2f%%)"
}
```

The legend will show:

```ruby
# =>
#      x**       * BTC 5977 (54.08%)
#   xxxx*****
# ++++xx*******
# ++++++*******  + BCH 3045 (27.55%)
# ++++++*******
#   ++++*****
#      +**       x LTC 2030 (18.37%)
```

To display value as currency use `<currency>` name string in the format:

```ruby
legend: {
  format: "%<label>s %<name>s $%<currency>s (%<percent>.0f%%)"
}
```

The legend will show:

```ruby
# =>
#      x**       * BTC $5,977 (54%)
#   xxxx*****
# ++++xx*******
# ++++++*******  + BCH $3,045 (28%)
# ++++++*******
#   ++++*****
#      +**       x LTC $2,030 (18%)
```

The currency can be further customised using `:precision` and `:delimiter` keys:

```ruby
legend: {
  format: "%<label>s %<name>s $%<currency>s (%<percent>.0f%%)",
  precision: 3,
  delimiter: "*"
}
```

The legend will show:

```ruby
# =>
#      x**       * BTC $5*977.123 (54%)
#   xxxx*****
# ++++xx*******
# ++++++*******  + BCH $3*045.200 (28%)
# ++++++*******
#   ++++*****
#      +**       x LTC $2*030.444 (18%)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/piotrmurach/tty-pie. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/piotrmurach/tty-pie/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the TTY::Pie project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/piotrmurach/tty-pie/blob/master/CODE_OF_CONDUCT.md).

## Copyright

Copyright (c) 2018 Piotr Murach. See [LICENSE.txt](https://github.com/piotrmurach/tty-pie_chart/blob/master/LICENSE.txt) for further details.
