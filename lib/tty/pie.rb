# frozen_string_literal: true

require "pastel"
require "tty-cursor"

require_relative "pie/data_item"
require_relative "pie/version"

module TTY
  class Pie
    FULL_CIRCLE_DEGREES = 360

    POINT_SYMBOL = "•"

    LEGEND_LINE_SPACE = 1

    LEGEND_LEFT_SPACE = 4

    attr_reader :top, :left

    attr_reader :center_x, :center_y

    attr_reader :radius

    attr_reader :aspect_ratio

    attr_reader :cursor

    attr_reader :fill

    attr_reader :colors

    attr_reader :legend

    # Create pie chart
    #
    # @example
    #   data = [ { name: "BTC", value: 5977, fill: "*" } ]
    #   pie_chart = TTY::Pie.new(data: data, radius: 2)
    #
    # @param [Array[Hash]] data
    #   the data to display in each slice
    # @param [Integer] top
    # @param [Integer] left
    # @param [Integer] radius
    # @param [Hash,Boolean] legend
    # @param [String] fill
    # @param [Float] aspect_ratio
    #
    # @api public
    def initialize(data: [], top: nil, left: nil, radius: 10,
                   legend: {}, fill: POINT_SYMBOL, aspect_ratio: 2,
                   colors: [])
      @data = data.dup
      @top = top
      @left = left
      @radius = radius
      @legend = legend
      @fill = Array(fill)
      @colors = Array(colors)
      @aspect_ratio = aspect_ratio
      @center_x = (left || 0) + radius * aspect_ratio
      @center_y = (top || 0) + radius

      @pastel = Pastel.new(enabled: !!colors)
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
      @data.each_with_index.map do |item, i|
        percent = (item[:value] * 100) / total_value.to_f
        color_fill = item[:fill] || fill[i % fill.size]
        color = colors && !colors.empty? ? colors[i % colors.size] : item.fetch(:color, false)
        DataItem.new(item[:name], item[:value], percent, color, color_fill)
      end
    end

    # Add a data item
    #
    # @param [Hash]
    #
    # @return [self]
    #
    # @api public
    def add(item)
      @data << item
      self
    end
    alias << add

    # Replace current data with new set
    #
    # @param [Array[Hash]]
    #
    # @api public
    def update(data)
      @data = data
      self
    end

    # Draw a pie based on the provided data
    #
    # @return [String]
    #
    # @api public
    def render
      items = data_items
      return "" if items.empty?
      angles = data_angles(items)
      output = []

      labels = items.map { |item| item.to_label(legend) }
      label_vert_space  = legend_line
      label_horiz_space = legend_left
      label_offset  = labels.size / 2
      label_boundry = label_vert_space * label_offset
      labels_range  = (-label_boundry..label_boundry).step(label_vert_space)

      (-radius..radius).each do |y|
        width = (Math.sqrt(radius * radius - y * y) * aspect_ratio).round
        width = width.zero? ? (radius / aspect_ratio).round : width

        output << " " * (center_x - width) if top.nil?
        (-width..width).each do |x|
          angle = radian_to_degree(Math.atan2(x, y))
          item = items[select_data_item(angle, angles)]
          if !top.nil?
            output << cursor.move_to(center_x + x, center_y + y)
          end
          if item.color
            output << @pastel.decorate(item.fill, item.color)
          else
            output << item.fill
          end
        end

        if legend
          if !top.nil?
            output << cursor.move_to(center_x + aspect_ratio * radius + label_horiz_space, center_y + y)
          end
          if labels_range.include?(y)
            if top.nil?
              output << " " * ((center_x - (left.to_i + width)) + label_horiz_space)
            end
            output << labels[label_offset + y / label_vert_space]
          end
        end

        output << "\n"
      end

      output.join
    end
    alias to_s render

    # Reset data
    #
    # @api public
    def clear
      @data = []
      self
    end
    alias reset clear

    private

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

    # The space between a legend and a chart
    #
    # @return [Integer]
    #
    # @api private
    def legend_left
      legend ? legend.fetch(:left, LEGEND_LEFT_SPACE) : LEGEND_LEFT_SPACE
    end

    # The space between each legend item
    #
    # @return [Integer]
    #
    # @api private
    def legend_line
      (legend ? legend.fetch(:line, LEGEND_LINE_SPACE) : LEGEND_LINE_SPACE) + 1
    end

    # Select data item index based on angle
    #
    # @return [Integer]
    #
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
  end # Pie
end # TTY
