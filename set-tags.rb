#!/usr/bin/env ruby

Dir.glob('*.mp3') do |f|
  puts f
  slices = f.split(" - ")
  album = slices[0]
  track = slices[1]
  artist = slices[2].gsub("'", "")
  song = slices[3][0..-5].gsub("'", "")
  puts song if song.include? "'"
  # puts "/usr/local/Cellar/id3v2/0.1.12/bin/id3v2 --artist '#{artist}' --album '#{album}' --track #{track} --song '#{song}' '#{f}'"
  puts `/usr/local/Cellar/id3v2/0.1.12/bin/id3v2 --artist '#{artist}' --album '#{album}' --track #{track} --song '#{song}' "#{f}"`
end
