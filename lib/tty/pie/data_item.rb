# frozen_string_literal: true

require "pastel"

module TTY
  class Pie
    # Encapsulates a single data item
    #
    # @api private
    class DataItem
      # Default legend label format
      #
      # @return [String]
      #
      # @api private
      LABEL_FORMAT = "%<label>s %<name>s %<percent>.2f%%"

      # The name for lenged label
      #
      # @return [String]
      #
      # @api public
      attr_accessor :name

      # The value for legend label
      #
      # @return [Numeric]
      #
      # @api public
      attr_accessor :value

      # The percentage size of a pie slice
      #
      # @return [Numeric]
      #
      # @api public
      attr_accessor :percent

      # The start angel for pie slice
      #
      # @return [Float]
      #
      # @api public
      attr_writer :angle

      # The color to use to mark pie slice
      #
      # @return [Symbol]
      #
      # @api public
      attr_accessor :color

      # The symbol to use to mark pie slice
      #
      # @return [String]
      #
      # @api public
      attr_accessor :fill

      # Creat a DataItem
      #
      # @example
      #   TTY::Pie::DataItem.new("BTC", 5977, 54, :yellow, "*")
      #
      # @param [String] name
      #   the name for legend label
      # @param [Numeric] value
      #   the value for legend label
      # @param [Float] percent
      #   the percentage size of a pie slice
      # @param [Symbol] color
      #   the color to use to mark pie slice
      # @param [String] fill
      #   the symbol to use to mark pie slice
      #
      # @api public
      def initialize(name, value, percent, color, fill)
        @name = name
        @value = value
        @color = color
        @percent = percent
        @fill = fill
        @pastel = Pastel.new(enabled: !!color)
      end

      # The item start angle
      #
      # @return [Float]
      #
      # @api public
      def angle
        percent * FULL_CIRCLE_DEGREES / 100.to_f
      end

      # Convert a data item into a legend label
      #
      # @example
      #   data_item = DataItem.new("BTC", 5977, 54, :yellow, "*")
      #   data_item.to_label({})
      #   # => "\e[33m*\e[0m BTC 54.00%"
      #
      # @param [Hash{Symbol => String,Integer}] legend
      #   the legend data to use to format label
      #
      # @return [String]
      #
      # @api public
      def to_label(legend)
        pattern   = legend && legend[:format] || LABEL_FORMAT
        precision = legend && legend[:precision] || 2
        delimiter = legend && legend[:delimiter] || ","

        label = color ? @pastel.decorate(fill, color) : fill
        currency = number_to_currency(value, precision: precision,
                                             delimiter: delimiter)

        format(pattern, label: label, name: name, value: value,
                        percent: percent, currency: currency)
      end

      private

      # Convert a number to a currency
      #
      # @example
      #   data_item.number_to_currency(5977.1234)
      #   # => "5,977.12"
      #
      # @param [Numeric] value
      #   the value to use for formatting
      # @param [Integer] precision
      #   the precision to determine decimal places, defaults to 2
      # @param [String] delimiter
      #   the delimiter to use to separate the thousands part
      #
      # @return [String]
      #
      # @api private
      def number_to_currency(value, precision: 2, delimiter: ",")
        whole, part = value.to_s.split(".")
        unless part.nil?
          part = format("%.#{precision}f", part.to_f / 10**part.size)[1..-1]
        end
        "#{whole.gsub(/(\d)(?=(\d{3})+(?!\d))/, "\\1#{delimiter}")}#{part}"
      end
    end
  end # Pie
end # TTY
