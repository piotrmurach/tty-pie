# frozen_string_literal

require 'pastel'

module TTY
  class PieChart
    class DataItem
      attr_accessor :name

      attr_accessor :value

      attr_accessor :percent

      attr_accessor :angle

      attr_accessor :color

      attr_accessor :fill

      # Creat a DataItem
      #
      # @api private
      def initialize(name, value, percent, angle, color, fill)
        @name = name
        @value = value
        @color = color
        @percent = percent
        @angle = angle
        @fill = fill
        @pastel = Pastel.new
      end

      # Convert a data item into a legend label
      #
      # @return [String]
      #
      # @api private
      def to_label
        percent_fmt = '%.2f' % percent
        "#{@pastel.decorate(fill, color)} #{name} #{percent_fmt}%"
      end
    end
  end # PieChart
end # TTY
