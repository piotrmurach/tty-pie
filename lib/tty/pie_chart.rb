# frozen_string_literal: true

require 'pastel'
require 'tty-cursor'

require_relative 'pie_chart/data_item'
require_relative 'pie_chart/version'

module TTY
  class PieChart
    FULL_CIRCLE_DEGREES = 360

    attr_reader :top, :left

    attr_reader :center_x, :center_y

    attr_reader :radius

    attr_reader :aspect_ratio

    attr_reader :cursor

    attr_reader :fill

    attr_reader :legend

    # Create pie chart
    #
    # @param [Array[Hash]] data
    #   the data to display in each slice
    # @param [Integer] top
    # @param [Integer] left
    # @param [Integer] radius
    # @param [Boolean] legend
    # @param [String] fill
    # @param [Float] aspect_ratio
    #
    # @api public
    def initialize(data, top: nil, left: nil, radius: 10, legend: true, fill: '•', aspect_ratio: 2)
      @data = data
      @top = top
      @left = left
      @radius = radius
      @legend = legend
      @fill = fill
      @aspect_ratio = aspect_ratio
      @center_x = (left || 0) + radius * aspect_ratio
      @center_y = (top || 0) + radius

      @pastel = Pastel.new
      @cursor = TTY::Cursor
    end

    # Total for the data items
    #
    # @return [Integer]
    #
    # @api private
    def total
      @data.inject(0) { |sum, item| sum += item[:value]; sum }
    end

    # Convert data into DataItems
    #
    # @return [Array[DataItem]]
    #
    # @api private
    def data_items
      total_value = total
      @data.map do |item|
        percent = (item[:value] * 100) / total_value.to_f
        angle = percent * FULL_CIRCLE_DEGREES / 100.to_f
        color_fill = item[:fill] || fill
        DataItem.new(item[:name], item[:value], percent, angle,
                     item[:color], color_fill)
      end
    end

    # All angles from the data to slice the pie
    #
    # @return [Array[Numeric]]
    #
    # @api private
    def data_angles(items)
      start_angle = 0
      items.reduce([]) do |acc, item|
        acc << start_angle + item.angle
        start_angle += item.angle
        acc
      end
    end

    # Draw a pie based on the provided data
    #
    # @return [String]
    #
    # @api public
    def draw
      items = data_items
      angles = data_angles(items)
      output = []

      labels = items.map(&:to_label)
      label_vert_space  = 2
      label_horiz_space = 4
      label_offset  = labels.size / 2
      label_boundry = label_vert_space * label_offset
      labels_range  = (-label_boundry..label_boundry).step(label_vert_space)

      (-radius..radius).each do |y|
        width = (Math.sqrt(radius * radius - y * y) * aspect_ratio).round
        width = width.zero? ? (radius / aspect_ratio).round : width

        output << ' ' * (center_x - width) if top.nil?
        (-width..width).each do |x|
          angle = radian_to_degree(Math.atan2(x, y))
          idx = select_data_item(angle, angles)
          if !top.nil?
            output << cursor.move_to(center_x + x, center_y + y)
          end
          output << @pastel.decorate(items[idx].fill, items[idx].color)
        end

        if legend
          if !top.nil?
            output << cursor.move_to(center_x + aspect_ratio * radius + label_horiz_space, center_y + y)
          end
          if labels_range.include?(y)
            output << ' ' * ((center_x - width) + label_horiz_space) if top.nil?
            output << labels[label_offset + y / label_vert_space]
          end
        end

        output << "\n"
      end

      output.join
    end

    # @api private
    def select_data_item(angle, angles)
      angles.index { |a| (FULL_CIRCLE_DEGREES / 2 - angle) < a }
    end

    # Convert radians to degrees
    #
    # @param [Float] radians
    #
    # @return [Float]
    #
    # @api private
    def radian_to_degree(radians)
      radians * 180 / Math::PI
    end
  end # PieChart
end # TTY
