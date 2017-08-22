#!/usr/bin/env ruby

require 'fileutils'
require 'set'

srcdir = '/Users/davidresnick/Desktop/pics'
Dir.chdir(srcdir)
Dir.glob('*') do |item|
  # IMG_20160116_171144
  # 2015-10-08 14.20.24
  puts item
  match = /(PANO|IMG|VID)_(?<year>\d{4})(?<mon>\d{2})(?<day>\d{2})_(?<hour>\d{2})(?<min>\d{2})(?<sec>\d{2})/.match(item)
  year = item[4,4]
  mon = item[8,2]
  day = item[10,2]
  hour = item[13,2]
  min = item[15,2]
  sec = item[17,2]
  dest = match[:year] + '-' + match[:mon] + '-' + match[:day] + ' ' + match[:hour] + '.' + match[:min] + '.' + match[:sec] + File.extname(item)
  # puts dest
  File.rename(item, dest)
end
