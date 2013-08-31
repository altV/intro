class Grammar
  extend Intro::Sys
  Awesome = Grammar.new :awesome,
    'at one'   => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][1])' },
    'at two'   => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][2])' },
    'at three' => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][3])' },
    'at four'  => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][4])' },
    'at five'  => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][5])' },
    'at six'   => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][6])' },
    'at seven' => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][7])' },
    'at eight' => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][8])' },
    'at nine'  => ->(w) { awesome 'awful.tag.viewonly(tags[mouse.screen][9])' },
    'at nex'   => ->(w) { awesome 'awful.client.focus.byidx(1)'               },
    'at prev'  => ->(w) { awesome 'awful.client.focus.byidx(-1)'              },

    'help'  => ->(w) { notify Intro.current_grammars.map(&:to_s).join("\n\n"), 20_000 }
end
