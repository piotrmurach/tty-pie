# frozen_string_literal

require 'pastel'

module TTY
  class Pie
    class DataItem
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
        @pastel = Pastel.new
      end

      # The item start angle
      #
      # @api private
      def angle
        percent * FULL_CIRCLE_DEGREES / 100.to_f
      end

      # Convert a data item into a legend label
      #
      # @return [String]
      #
      # @api private
      def to_label
        percent_fmt = '%.2f' % percent
        label = color ? @pastel.decorate(fill, color) : fill
        "#{label} #{name} #{percent_fmt}%"
      end
    end
  end # Pie
end # TTY
