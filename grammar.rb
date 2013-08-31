class Grammar < Hash
  attr_accessor :name
  def to_s
    "<#{name}> exported = " + self.keys.join(' | ') + ";"
  end
  def self.[] name, grammar_hash
    super(grammar_hash).tap {|e| e.name = name }
  end
  def self.new name, grammar_hash
    self.[] name, grammar_hash
  end


  def self.process words_with_grammars
    return if words_with_grammars.size == 0
    beginning_word_grammar = words_with_grammars[0][1]
    this_word_grammar_is_beginning_word_grammar = ->(e){ e[1] == beginning_word_grammar }

    "grammar/#{beginning_word_grammar}".camelize.constantize.process_words \
      words_with_grammars.take_while(&this_word_grammar_is_beginning_word_grammar).
        map {|e| e[0]}

    process words_with_grammars.drop_while &this_word_grammar_is_beginning_word_grammar
  rescue StandardError => e
    p e
    p e.backtrace
  end

  def process_words words
    case
    when words.size == 0
    when cmd = keys.find {|e| e == words.first }
      self[cmd].call nil
      words.shift 1
      process_words words
    when cmd = keys.find {|e| e == words.join(' ') }
      self[cmd].call nil
      words.shift 2
      process_words words
    when cmd = keys.find {|e| e == words.join(' ') }
      self[cmd].call nil
      words.shift 2
      process_words words
    end
  end
end
