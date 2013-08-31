class Grammar
  SayType = Grammar.new :say_type,
    'say  <dgndictation>' =>    ->(w) { `xte 'str #{w[1..-1].join(' ')}'` },
    'word <dgnwords>'     =>    ->(w) { `xte 'str #{w[1..-1].join(' ')}'` },
    'let  <dgnletters>'   =>    ->(w) { `xte 'str #{w[1..-1].join(' ')}'` },
    'type <dgndictation>' =>    ->(w) {
      `xte 'str #{w[1..-1].join(' ')}'`
      `xte 'key Return'`
    }
end
