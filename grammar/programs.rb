class Grammar
  Programs = Grammar.new :programs,
    'launch browser' => ->(w) { `google-chrome` },
    'launch gedit'   => ->(w) { `gedit` }
end
