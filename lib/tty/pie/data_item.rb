# frozen_string_literal: true

require "pastel"

module TTY
  class Pie
    # Encapsulates a single data item
    class DataItem
      LABEL_FORMAT = "%<label>s %<name>s %<percent>.2f%%"

      attr_accessor :name

      attr_accessor :value

      attr_accessor :percent

      attr_writer :angle

      attr_accessor :color

      attr_accessor :fill

      # Creat a DataItem
      #
      # @api private
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
      # @api private
      def angle
        percent * FULL_CIRCLE_DEGREES / 100.to_f
      end

      # Convert a data item into a legend label
      #
      # @param [Hash] legend
      #
      # @return [String]
      #
      # @api private
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

      # Convert a number to a currency
      #
      # @param [Numeric] value
      # @param [Integer] precision
      # @param [String] delimiter
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
