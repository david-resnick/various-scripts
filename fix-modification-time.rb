#!/usr/bin/env ruby

require 'fileutils'
require 'set'

# Saturday, January 1, 2011 at 02:30 --> Sunday, April 17, 2016 at 11:20
diff = Time.new(2016, 4, 17, 11, 20, 0, "+02:00").to_i - Time.new(2011, 1, 1, 2, 30, 0, "+02:00").to_i

srcdir = '/Users/davidresnick/Desktop/dolphin reef/100MSDCF copy'
Dir.chdir(srcdir)
Dir.glob('*') do |item|
  puts item
  old = File.mtime(item)
  correct = Time.at(old.to_i + diff)
  puts correct
  FileUtils.touch item, :mtime => correct
end
