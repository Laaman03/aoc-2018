class LetterNode
  def initialize(character)
    @character = character
    @children = []
  end

  attr_accessor :character
  attr_reader :children

  def add_child(node)
    @children.push(node)
  end

  def try_path(path)
    if path.length == 1
      return path
    end
    next_node = @children.find{|node| node.character == path[0]}
    if next_node.nil?
      has_possible_route = try_path_grand_children(path[1..])
      if has_possible_route
        return path
      else
        add_child(self.class.str_to_tree(path))
        return ""
      end
    else
      return next_node.try_path(path[1..])
    end
  end

  def try_path_grand_children(path)
    c = path[0]
    nodes = @children.flat_map{|node| node.children}.select{|node| node.character == c}
    nodes.any?{|node| node.try_exact_path(path[1..])}
  end

  def try_exact_path(path)
    if path.length == 1
      return @children.any?{|node| node.character == path}
    end
    next_node = @children.find{|node| node.character == path[0]}
    if next_node.nil?
      return false
    else
      return next_node.try_exact_path(path[1..])
    end
  end

  def self.str_to_tree(path)
    original = LetterNode.new(path[0])
    pointer = original
    path[1..].each_char do |c|
      node = LetterNode.new(c)
      pointer.add_child(node)
      pointer = node
    end
    original
  end

end

root = LetterNode.new(nil)
File.readlines('input').each do |line|
  result = root.try_path(line.strip)
  if !result.empty?
    line.slice!((line.length - 1) - result.length)
    puts line
    break
  end
end

