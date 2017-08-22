#!/usr/bin/env ruby

id3v2 = "/usr/local/Cellar/id3v2/0.1.12/bin/id3v2"

Dir.glob('*.mp3') do |f|
  f = f.gsub("'", %q(''))
  match = /(?<track>\d{2}) Queen - (?<title>.*)\.mp3$/.match(f)
  cmd = "#{id3v2} --artist 'Queen' --album 'Queen live setlist' --track #{match[:track]} --song '#{match[:title]}' '#{f}'"
  puts cmd
  puts `#{id3v2} --artist 'Queen' --album 'Queen live setlist' --track #{match[:track]} --song '#{match[:title]}' '#{f}'`
end
