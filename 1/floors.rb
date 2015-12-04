steps = File.read("input.txt")
steps = steps.split("")
puts steps.count

floor = 0

steps.each_with_index do |s, i|
  if s == '('
    floor += 1
  elsif s == ')'
    floor -= 1
  end

  if floor == -1
    puts i + 1
    break
  end
end

puts "last floor = #{floor}"
