class Grammar < Hash
  attr_accessor :name
  def to_s
    "<#{name}> exported = " + self.keys.join(' | ') + ";"
  end
  def self.[] name, grammar_hash
    super(grammar_hash).tap {|e| e.name = name }
  end
end
