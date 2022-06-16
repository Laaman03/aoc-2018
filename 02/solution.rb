require 'set'

total_twos = 0
total_threes = 0
File.readlines('input').each do |line|
  hash = Hash.new
  twos_candidates = Set.new
  threes_candidates = Set.new
  line.each_char do |char|
    if hash.has_key?(char)
      hash[char]+= 1
      count = hash[char]
      if count == 2
        twos_candidates.add(char)
      elsif count == 3
        twos_candidates.delete(char)
        threes_candidates.add(char)
      elsif count > 3
        threes_candidates.delete(char)
      end
    else
      hash[char] = 1
    end
  end
  if !twos_candidates.empty?()
    total_twos += 1
  end
  if !threes_candidates.empty?()
    total_threes += 1
  end
end
puts total_twos * total_threes

