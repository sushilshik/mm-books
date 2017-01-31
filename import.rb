#!/usr/bin/ruby
# encoding: UTF-8
require_relative 'builder'

x = 100
y = 100

prefix = ARGV[0]

mm_output_path = "./#{prefix}.vue"
pagesDirPath = Dir.pwd + "/#{prefix}/"

pagesAmount = ARGV[1].to_i
pageWidth = ARGV[2].gsub(",","").to_i
pageHeight = ARGV[3].gsub(",","").to_i

if prefix.nil? || pagesAmount.nil? || pageWidth.nil? || pageHeight.nil?
  puts "properties: pagesAmount pageWidth pageHeight"
  exit
end
b = Builder.new()
b.mm_output_path = mm_output_path
b.x = x
b.y = y
b.pagesAmount = pagesAmount
b.pagesDirPath = pagesDirPath
b.pageFilePrefix = prefix+"_"
b.pageFileEnding = ".jpg"
b.pageFileFormat = "jpg"
b.pageScaleDown = 2
b.pageWidth = pageWidth/b.pageScaleDown
b.pageHeight = pageHeight/b.pageScaleDown
b.startPositionX = 0
b.startPositionY = 0
b.pagesLayoutX = 10
b.pagesLayoutY = 10
#b.pagesLayoutStepX = 3000/b.pageScaleDown
#b.pagesLayoutStepY = 3000/b.pageScaleDown
b.pagesLayoutStepX = 2.2*b.pageWidth
b.pagesLayoutStepY = 1.07*b.pageHeight
b.pagesLayoutPlateStepY = b.pageHeight
b.pageLayoutPositionY = b.startPositionY
b.buildForPages()

# vim: tabstop=4 softtabstop=0 noexpandtab shiftwidth=4 number
