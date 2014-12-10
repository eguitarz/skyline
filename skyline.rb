class Skyline
  class Building
    def left
      @left
    end

    def right
      @right
    end

    def height
      @height
    end

    def include?(pos)
      pos >= @left && pos < @right
    end

    def initialize(left, right, height)
      @left = left
      @right = right
      @height = height
    end
  end

  def scan_critical_points(input)
    buildings = []
    critical_points = {}
    
    (input.length/3).times.each do |i|
      left = input[i*3]
      right = input[i*3+2]
      height = input[i*3+1]
      buildings << Building.new(left, right, height)

      buildings.map {|building| [building.left, building.right]}.flatten.each do |point|
        critical_points[point] = buildings.select{|b| b.include? point}
      end
    end

    # buildings
    critical_points
  end

  def generate_output(critical_points)
    last_height = 0
    critical_points.sort.each do |point, building_array|
      max_height_building = building_array.max_by(&:height)
      max_height = if max_height_building then max_height_building.height else 0 end

      if max_height != last_height
        @output << point
        @output << max_height
        last_height = max_height
      end
    end
  end

  def initialize(input)
    @input = input
    @output = []
    critical_points = scan_critical_points @input
    generate_output critical_points
  end

  def input
    @input
  end

  def output
    @output
  end
  
end

skyline = Skyline.new [1, 11, 5, 1, 20, 6, 2, 6, 7, 3, 13, 9, 12, 7, 16, 14, 3, 25, 15, 8, 16, 19, 18, 22, 23, 13, 29, 24, 4, 28]
puts "input: #{skyline.input}"
puts "output: #{skyline.output}"