module Bash
  extend self

  def process grammar; end
  def list_actions grammar; end

  Directory = [
    {
      name: 'change', # change :: Directory -> ()
      arg1: 'Directory',
      action: ->(d) { "cd #{d}" },
      result: '',
      tags: 'change directory, path'
    },

    {
      name: 'show', # show :: Directory -> [Directory]
      arg1: 'Directory',
      action: ->(d) { "ls #{d}" },
      result: '',
      tags: 'change directory, path'
    },

    {
      name: '#new', # new :: () -> Directory
      arg1: 'Directory',
      action: ->(d) { "cd #{d}" },
      result: '',
      tags: 'change directory, path'
    },

    {
      name: 'to_s', # change :: Directory -> ()
      arg1: 'Directory',
      action: ->(d) { "cd #{d}" },
      result: '',
      tags: 'change directory, path'
    },

    {
      name: 'delete', # delete :: Directory -> ()
      arg1: 'Directory',
      action: ->(d) { "rm #{d}" },
      result: '',
      tags: 'rm directory, path'
    }
  ]
end
