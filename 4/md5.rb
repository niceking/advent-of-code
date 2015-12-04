require "digest"

key = "bgvyzdsv"

num = 0

100000000.times do |i|
  input = key + i.to_s
  output = Digest::MD5.hexdigest input
  # p "#{input}, #{output}"
  num = i if /^0{6}/.match(output)
  break if /^0{6}/.match(output)
end

puts "#{num}"
