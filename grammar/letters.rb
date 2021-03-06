class Grammar
  Letters = Grammar.new :letters,
    'apple'   => ->(w) { `xte 'str A'` },
    'ash'     => ->(w) { `xte 'str a'` },
    'boom'    => ->(w) { `xte 'str B'` },
    'big'     => ->(w) { `xte 'str b'` },
    'cook'    => ->(w) { `xte 'str C'` },
    'cat'     => ->(w) { `xte 'str c'` },
    'dim'     => ->(w) { `xte 'str D'` },
    'dog'     => ->(w) { `xte 'str d'` },
    'easy'    => ->(w) { `xte 'str E'` },
    'egg'     => ->(w) { `xte 'str e'` },
    'Fay'     => ->(w) { `xte 'str F'` },
    'far'     => ->(w) { `xte 'str f'` },
    'Goff'    => ->(w) { `xte 'str G'` },
    'gim'     => ->(w) { `xte 'str g'` },
    'Hoop'    => ->(w) { `xte 'str H'` },
    'her'     => ->(w) { `xte 'str h'` },
    'Ike'     => ->(w) { `xte 'str I'` },
    'is'      => ->(w) { `xte 'str i'` },
    'Joe'     => ->(w) { `xte 'str J'` },
    'jim'     => ->(w) { `xte 'str j'` },
    'Keel'    => ->(w) { `xte 'str K'` },
    'cai'     => ->(w) { `xte 'str k'` },
    'Lee'     => ->(w) { `xte 'str L'` },
    'lick'    => ->(w) { `xte 'str l'` },
    'Mike'    => ->(w) { `xte 'str M'` },
    'moon'    => ->(w) { `xte 'str m'` },
    'Noy'     => ->(w) { `xte 'str N'` },
    'nor'     => ->(w) { `xte 'str n'` },
    'Osc'     => ->(w) { `xte 'str O'` },
    'Osh'     => ->(w) { `xte 'str o'` },
    'Pui'     => ->(w) { `xte 'str P'` },
    'pom'     => ->(w) { `xte 'str p'` },
    #'Quebec' => ->(w) { `xte 'str Q'` },
    'Queen'   => ->(w) { `xte 'str Q'` },
    'queue'   => ->(w) { `xte 'str q'` },
    'Roy'     => ->(w) { `xte 'str R'` },
    'ree'     => ->(w) { `xte 'str r'` },
    'Soi'     => ->(w) { `xte 'str S'` },
    'see'     => ->(w) { `xte 'str s'` },
    'Tay'     => ->(w) { `xte 'str T'` },
    'tea'     => ->(w) { `xte 'str t'` },
    'Umm'     => ->(w) { `xte 'str U'` },
    'uff'     => ->(w) { `xte 'str u'` },
    'Van'     => ->(w) { `xte 'str V'` },
    'vim'     => ->(w) { `xte 'str v'` },
    'Woop'    => ->(w) { `xte 'str W'` },
    'wes'     => ->(w) { `xte 'str w'` },
    'Xor'     => ->(w) { `xte 'str X'` },
    'ex'      => ->(w) { `xte 'str x'` },
    'Yaa'     => ->(w) { `xte 'str Y'` },
    'you'     => ->(w) { `xte 'str y'` },
    'Zul'     => ->(w) { `xte 'str Z'` },
    'zee'     => ->(w) { `xte 'str z'` },

    'pum'    => ->(w) { `xte 'key Space'` },
    'pysh'    => ->(w) { `xte 'key Return'` },
    'never'   => ->(w) { `xte 'key Escape'` },
    'quote'   => ->(w) { `xte "str '"` },
    'dub'   => ->(w) { `xte 'str "'` },
    'break'   => ->(w) { `xte 'keydown Control_L' 'key c' 'keyup Control_L'` },
    'exit'   => ->(w) { `xte 'keydown Control_L' 'key d' 'keyup Control_L'` },

    'one'   => ->(w) { `xte 'str 1'` },
    'two'   => ->(w) { `xte 'str 2'` },
    'three' => ->(w) { `xte 'str 3'` },
    'four'  => ->(w) { `xte 'str 4'` },
    'five'  => ->(w) { `xte 'str 5'` },
    'six'   => ->(w) { `xte 'str 6'` },
    'seven' => ->(w) { `xte 'str 7'` },
    'eight' => ->(w) { `xte 'str 8'` },
    'nine'  => ->(w) { `xte 'str 9'` },
    'zero'  => ->(w) { `xte 'str 0'` }
end
