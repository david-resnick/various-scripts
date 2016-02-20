#!/usr/bin/env ruby

require 'fileutils'
require 'set'

srcdir = '/Users/davidresnick/Desktop/for-picasa'
dest = '/Users/davidresnick/Desktop/pics-to-move'
Dir.chdir(srcdir)
buckets = Hash.new
Dir.glob('*.{JPG,mp4}') do |item|
  key = item[0,10]
  if buckets.has_key?(key)
    buckets[key].add(item)
  else
    buckets[key] = Set.new [item]
  end
end
buckets.each do |key, set|
  targetdir = dest + "/" + key
  puts "mkdir " + targetdir
  FileUtils.mkdir_p targetdir
  set.each do |file|
    FileUtils.mv(srcdir + "/" + file, targetdir + "/" + file)
  end
end
