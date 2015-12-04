class Package
 def initialize(d)
   @l = d[0].to_i
   @w = d[1].to_i
   @h = d[2].to_i
 end

 def to_s
   puts "length: #{@l}, width: #{@w}, height: #{@h}"
 end

 def ordered_dimensions
   [@l, @h, @w].sort
 end

 def surface_area
   2 * @l * @w + 2 * @w * @h + 2 * @h * @l
 end

 def slack
   ordered_dimensions[0] * ordered_dimensions[1]
 end

 def paper_length
   surface_area + slack
 end

 def ribbon_length
   (ordered_dimensions[0] + ordered_dimensions[1]) * 2 + (@l * @w * @h)
 end
end

raw_packages = File.read("input.txt")
raw_packages = raw_packages.split("\n")

packages = []

raw_packages.each do |p|
  packages.push(Package.new(p.split('x')))
end

total_wrapping_paper = 0
packages.each { |p| total_wrapping_paper += p.paper_length }

puts "Total wrapping paper: #{total_wrapping_paper}"

total_ribbon = 0
packages.each { |p| total_ribbon += p.ribbon_length }

puts "Total ribbon: #{total_ribbon}"
