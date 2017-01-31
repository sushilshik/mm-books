#!/usr/bin/ruby
#2017-01-30 20:36:53
# encoding: UTF-8
require "open3"
require 'fileutils'

class MMBookBuilder
	attr_accessor :prefix,
	    :pdfFilePath,
	    :djvuFilePath,
	    :pdfFileSavePath,
	    :outputPath,
	    :outputFileName,
	    :outputFileEnding,
	    :pages,
	    :pagesImgsDirPath,
	    :pagesSelectedSizes,
	    :sizesFrequencySorted,
	    :jobIndex,
	    :djVuLibreDirPath,
	    :sourceDir,
	    :wineDjVuLibreDirPath,
	    :allJobs,
	    :importScriptPath
	@@logFilePath = "./mmBooksGenLog.txt"
	@@errorsLogFilePath = "./mmBooksGenErrorsLog.txt"
	def initialize(prefix, jobIndex, allJobs)
		@prefix = prefix
		@jobIndex = jobIndex
		@allJobs = allJobs
		
		p "Job index: " + @jobIndex.to_s + ", Jobs count: " + @allJobs.size.to_s + ", prefix: " + @prefix
		MMBookBuilder.saveLogLine("Job index: " + @jobIndex.to_s + ", Jobs count: " + @allJobs.size.to_s + ", prefix: " + @prefix , @@logFilePath)
		
		@sourceDir = "./"
		@pdfFilePath = @sourceDir + @prefix + ".pdf"
		@importScriptPath = "./import.rb"
		#@djvuFilePath = @sourceDir + @prefix + ".djvu"
		#@djVuLibreDirPath = "/home/some_user/.wine/drive_c/Program Files (x86)/DjVuLibre/"
		#@wineDjVuLibreDirPath = "c:/Program\ Files\ \(x86\)/DjVuLibre/"
		
		#if !File.exists?(@pdfFilePath) && File.exists?(@djvuFilePath)
		#____p "buildPdfFileFromDjvu()"
		#____MMBookBuilder.saveLogLine("Job index: " + @jobIndex.to_s + ", prefix: " + @prefix + ", " + "buildPdfFileFromDjvu()", @@logFilePath)
		#____buildPdfFileFromDjvu()
		#else
		#____MMBookBuilder.saveLogLine("Job index: " + @jobIndex.to_s + ", prefix: " + @prefix + ", " + "No pdf and no djvu file exists", @@errorsLogFilePath)
		#end
		
		#@pdfFileSavePath = "./mm_books_source_files/"
		@outputPath = "./"
		@outputFileBaseName = @prefix
		@outputFileEnding = ".jpg"
		@pagesImgsDirPath = @outputPath + "/" + @prefix + "/"
		
		@pages = `pdfinfo #{@pdfFilePath} | grep Pages | awk '{print $2}'`
		puts "Всего страниц: " + @pages
	end
	def buildPdfFileFromDjvu()
		FileUtils.move(@djvuFilePath, @djVuLibreDirPath)
		command = 'wine "' + @djVuLibreDirPath + 'ddjvu.exe" -format=pdf "' + @wineDjVuLibreDirPath + @prefix + '.djvu" "' + @wineDjVuLibreDirPath + @prefix + '.pdf"'
		p command
		system(command)
		FileUtils.move(@djVuLibreDirPath + @prefix + ".pdf", @sourceDir )
		FileUtils.move(@djVuLibreDirPath + @prefix + ".djvu", @sourceDir + "djvu_files_to_delete/" )
	end
	def buildPages()
		Dir.mkdir @outputPath + "/" + @prefix
		
		@pages.to_i.times do |n|
		    print n.to_s + " - " + @pages.strip + ". "
		    $stdout.flush
		    command = "convert"
		    command += " -colorspace Gray "
		    command += " -alpha remove"
		    command += " -density 300"
		    command += " -quality 100"
		    #command += " -resize 50%"
		    command += " -resize '2700x2700>'"
		    command += " #{@pdfFilePath}[#{n}] "
		    command += " #{@outputPath+"/"+@prefix+"/"}#{@outputFileBaseName}_#{n}#{@outputFileEnding}"
		    system(command)
		end
	end
	def getPagesSizeMap()
		sizeLinesMap = {}
		files = Dir.entries(@pagesImgsDirPath).select{ |f|
		    !File.directory? f
		}.map { |f|
		    key = f.match(/.+_(.*).jpg/)[1].to_i
		    [key,f]
		}.to_h
		files.sort.select {|key,value|
		    command = "identify -format '%w %h' " + @pagesImgsDirPath + value
		    IO.popen(command) do |io|
		        while line = io.gets
		            sizeXY = line.split(" ").map{|l| l.to_i}
		            sizeLinesMap[key] = sizeXY
		        end
		    end
		}
		sizeLinesMap
	end
	def getPagesSelectedSizes()
		sizeLinesMap = getPagesSizeMap()
		sizesFrequency = sizeLinesMap.values.uniq.map{ |e| [ e, sizeLinesMap.values.count(e) ] }.to_h
		@sizesFrequencySorted = sizesFrequency.sort_by(&:last).reverse
		p "\n"+@sizesFrequencySorted.to_s
		MMBookBuilder.saveLogLine("Job index: " + @jobIndex.to_s + ", prefix: " + @prefix + ", " + @sizesFrequencySorted.to_s, @@logFilePath)
		@pagesSelectedSizes = sizesFrequency.select { |key, value| value > sizeLinesMap.size*0.75}
	end
	def self.saveLogLine(line, logFilePath)
		file = File.new(logFilePath, "a")
		file.write(Time.new.strftime("%Y-%m-%d %H:%M:%S") + " >>> " + line + "\n")
		file.close
	end
	def generateMMFile()
		if @pagesSelectedSizes.size > 0
		    x = @pagesSelectedSizes.keys[0][0].to_s
		    y = @pagesSelectedSizes.keys[0][1].to_s
		    command = @importScriptPath + " " + @prefix + " " + @pages.strip + " " + x + " " + y
		    p command
		    MMBookBuilder.saveLogLine("Job index: " + @jobIndex.to_s + ", prefix: " + @prefix + ", " + command, @@logFilePath)
		    system(command)
		else
		    alarmLine = "!!!!!!!!!!!!!!!!!!!!!!!!"
		    p alarmLine
		    MMBookBuilder.saveLogLine("Job index: " + @jobIndex.to_s + ", prefix: " + @prefix + ", " + alarmLine, @@logFilePath)
		    command = @importScriptPath + " " + @prefix + " " + @pages.strip
		    puts command
		    MMBookBuilder.saveLogLine("Job index: " + @jobIndex.to_s + ", prefix: " + @prefix + ", " + command, @@logFilePath)
		    MMBookBuilder.saveLogLine("Job index: " + @jobIndex.to_s + ", prefix: " + @prefix + ", " + @sizesFrequencySorted.to_s , @@errorsLogFilePath)
		    MMBookBuilder.saveLogLine("Job index: " + @jobIndex.to_s + ", prefix: " + @prefix + ", " + command, @@errorsLogFilePath)
		end
	end
	def clean()
		FileUtils.move(@pdfFilePath, @pdfFileSavePath)
	end
	def self.logFilePath
		@@logFilePath
	end
	def self.wrongPagesSizeLogFilePath
		@@wrongPagesSizeLogFilePath
	end
end


books_prefixes = ARGV

books_prefixes.each_with_index{ |prefix, index|

    builder = MMBookBuilder.new(prefix, index+1, books_prefixes)

    builder.buildPages()

    builder.getPagesSelectedSizes()

    builder.generateMMFile()

    #builder.clean()

}

# vim: tabstop=4 softtabstop=0 noexpandtab shiftwidth=4 number
