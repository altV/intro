class Grammar
  extend Dragon
  Main = Grammar.new :main,
    'away'      => ->(w) { mic_sleep },
    'wake up'      => ->(w) { mic_on },
    'ninja stop'      => ->(w) { exit_dragon },
end
