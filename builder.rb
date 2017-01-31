#!/usr/bin/ruby
# encoding: UTF-8

class Builder
	attr_accessor :path,
	:mm_output_path,
	:x,
	:y,
	:pagesAmount,
	:pageWidth,
	:pageHeight,
	:pageScaleDown,
	:startPositionX,
	:startPositionY,
	:pageFilePrefix,
	:pageFileEnding,
	:pagesDirPath,
	:pageFileFormat,
	:pagesLayoutX,
	:pagesLayoutY,
	:pagesLayoutStepX,
	:pagesLayoutStepY,
	:pagesLayoutPlateStepY,
	:pagesLayoutCounterX,
	:pagesLayoutCounterY,
	:pageLayoutPositionX,
	:pageLayoutPositionY,
	:vueFileContent
	@@line1 = '<!-- Tufts VUE 3.2.2 concept-map (mm.vue) 2015-10-01 -->' + "\n"
	@@line1 += '<!-- Tufts VUE: http://vue.tufts.edu/ -->' + "\n"
	@@line1 += '<!-- Do Not Remove: VUE mapping @version(1.1) jar:file:/home/mike/Desktop/VUE.jar!/tufts/vue/resources/lw_mapping_1_1.xml --> ' + "\n"
	@@line1 += '<!-- Do Not Remove: Saved date Thu Oct 01 04:42:19 MSK 2015 by mike on platform Linux 3.11.10-301.fc20.x86_64 in JVM 1.7.0_71-mockbuild_2014_12_09_14_04-b00 --> ' + "\n"
	@@line1 += '<!-- Do Not Remove: Saving version @(#)VUE: built May 23 2013 at 2146 by tomadm on Linux 2.6.18-348.2.1.el5 i386 JVM 1.7.0_21-b11(bits=32) --> ' + "\n"
	@@line1 += '<?xml version="1.0" encoding="US-ASCII"?> ' + "\n"
	@@line1 += '<LW-MAP xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" ' + "\n"
	@@line1 += 'xsi:noNamespaceSchemaLocation="none" ID="0" label="mm.vue" ' + "\n"
	@@line1 += 'created="1443663724553" x="0.0" y="0.0" width="345.0" height="216.0" ' + "\n"
	@@line1 += 'strokeWidth="0.0" autoSized="false"> ' + "\n"
	@@line1 += '<resource referenceCreated="1443663739636" ' + "\n"
	@@line1 += 'spec="/home/mike/Desktop/mm.vue" type="1" xsi:type="URLResource"> ' + "\n"
	@@line1 += '<title>mm.vue</title> ' + "\n"
	@@line1 += '<property key="File" value="/home/some_user/Desktop/mm.vue"/> ' + "\n"
	@@line1 += '</resource> ' + "\n"
	@@line1 += '<fillColor>#FFFFFF</fillColor> ' + "\n"
	@@line1 += '<strokeColor>#404040</strokeColor> ' + "\n"
	@@line1 += '<textColor>#000000</textColor> ' + "\n"
	@@line1 += '<font>SansSerif-plain-14</font> ' + "\n"
	@@line1 += '<URIString>http://vue.tufts.edu/rdf/resource/21107af47f0000017d5ab078fb204c8a</URIString>' + "\n"
	@@line2 = ' <layer ID="1" label="Layer 1" created="1443663724554" x="0.0" ' + "\n"
	@@line2 += 'y="0.0" width="1.4E-45" height="1.4E-45" strokeWidth="0.0" autoSized="false"> ' + "\n"
	@@line2 += '<URIString>http://vue.tufts.edu/rdf/resource/21107af57f0000017d5ab0784b0a5cec</URIString> ' + "\n"
	@@line2 += '</layer> ' + "\n"
	@@line2 += '<userZoom>1.0</userZoom> ' + "\n"
	@@line2 += '<userOrigin x="-14.0" y="-14.0"/> ' + "\n"
	@@line2 += '<presentationBackground>#202020</presentationBackground> ' + "\n"
	@@line2 += '<PathwayList currentPathway="0" revealerIndex="-1"> ' + "\n"
	@@line2 += '<pathway ID="0" label="Untitled Pathway" created="1443663724542" ' + "\n"
	@@line2 += 'x="0.0" y="0.0" width="1.4E-45" height="1.4E-45" ' + "\n"
	@@line2 += 'strokeWidth="0.0" autoSized="false" currentIndex="-1" open="true"> ' + "\n"
	@@line2 += '<strokeColor>#B3993333</strokeColor> ' + "\n"
	@@line2 += '<textColor>#000000</textColor> ' + "\n"
	@@line2 += '<font>SansSerif-plain-14</font> ' + "\n"
	@@line2 += '<URIString>http://vue.tufts.edu/rdf/resource/21107af57f0000017d5ab078daf10463</URIString> ' + "\n"
	@@line2 += '<masterSlide ID="2" created="1443663724630" x="0.0" y="0.0" ' + "\n"
	@@line2 += 'width="800.0" height="600.0" locked="true" ' + "\n"
	@@line2 += 'strokeWidth="0.0" autoSized="false"> ' + "\n"
	@@line2 += '<fillColor>#000000</fillColor> ' + "\n"
	@@line2 += '<strokeColor>#404040</strokeColor> ' + "\n"
	@@line2 += '<textColor>#000000</textColor> ' + "\n"
	@@line2 += '<font>SansSerif-plain-14</font> ' + "\n"
	@@line2 += '<URIString>http://vue.tufts.edu/rdf/resource/21107af57f0000017d5ab078a8bb7430</URIString> ' + "\n"
	@@line2 += '<titleStyle ID="3" label="Header" ' + "\n"
	@@line2 += 'created="1443663724646" x="329.0" y="174.5" ' + "\n"
	@@line2 += 'width="142.0" height="51.0" strokeWidth="0.0" ' + "\n"
	@@line2 += 'autoSized="true" isStyle="true" xsi:type="node"> ' + "\n"
	@@line2 += '<strokeColor>#404040</strokeColor> ' + "\n"
	@@line2 += '<textColor>#FFFFFF</textColor> ' + "\n"
	@@line2 += '<font>Gill Sans-plain-36</font> ' + "\n"
	@@line2 += '<URIString>http://vue.tufts.edu/rdf/resource/21107af57f0000017d5ab07896538a40</URIString> ' + "\n"
	@@line2 += '<shape xsi:type="rectangle"/> ' + "\n"
	@@line2 += '</titleStyle> ' + "\n"
	@@line2 += '<textStyle ID="4" label="Slide Text" ' + "\n"
	@@line2 += 'created="1443663724647" x="340.0" y="282.5" ' + "\n"
	@@line2 += 'width="120.0" height="35.0" strokeWidth="0.0" ' + "\n"
	@@line2 += 'autoSized="true" isStyle="true" xsi:type="node"> ' + "\n"
	@@line2 += '<strokeColor>#404040</strokeColor> ' + "\n"
	@@line2 += '<textColor>#FFFFFF</textColor> ' + "\n"
	@@line2 += '<font>Gill Sans-plain-22</font> ' + "\n"
	@@line2 += '<URIString>http://vue.tufts.edu/rdf/resource/21107af57f0000017d5ab078fa3e3377</URIString> ' + "\n"
	@@line2 += '<shape xsi:type="rectangle"/> ' + "\n"
	@@line2 += '</textStyle> ' + "\n"
	@@line2 += '<linkStyle ID="5" label="Links" created="1443663724648" ' + "\n"
	@@line2 += 'x="372.5" y="385.0" width="55.0" height="30.0" ' + "\n"
	@@line2 += 'strokeWidth="0.0" autoSized="true" isStyle="true" xsi:type="node"> ' + "\n"
	@@line2 += '<strokeColor>#404040</strokeColor> ' + "\n"
	@@line2 += '<textColor>#B3BFE3</textColor> ' + "\n"
	@@line2 += '<font>Gill Sans-plain-18</font> ' + "\n"
	@@line2 += '<URIString>http://vue.tufts.edu/rdf/resource/21107af57f0000017d5ab0789fa21035</URIString> ' + "\n"
	@@line2 += '<shape xsi:type="rectangle"/> ' + "\n"
	@@line2 += '</linkStyle> ' + "\n"
	@@line2 += '</masterSlide> ' + "\n"
	@@line2 += '</pathway> ' + "\n"
	@@line2 += '</PathwayList> ' + "\n"
	@@line2 += '<date>2015-10-01</date> ' + "\n"
	@@line2 += '<modelVersion>6</modelVersion> ' + "\n"
	@@line2 += '<saveLocation>/home/some_user/Desktop</saveLocation> ' + "\n"
	@@line2 += '<saveFile>/home/some_user/Desktop/mm.vue</saveFile> ' + "\n"
	@@line2 += '</LW-MAP> ' + "\n"
	def initialize()
		@pagesLayoutCounterX = 0
		@pagesLayoutCounterY = 0
	end
	def pageLayoutPosition()
		x = @pageLayoutPositionX
		y = @pageLayoutPositionY
		if @pagesLayoutCounterX == (@pagesLayoutX-1)
		   @pagesLayoutCounterX = 0
		   @pagesLayoutCounterY = @pagesLayoutCounterY + 1
		   @pageLayoutPositionY = @pageLayoutPositionY + @pagesLayoutStepY
		   if (@pagesLayoutCounterY % @pagesLayoutY) == 0 && (@pagesLayoutCounterY != 0)
		      @pageLayoutPositionY = @pageLayoutPositionY + @pagesLayoutPlateStepY
		   end
		else
		   @pagesLayoutCounterX = @pagesLayoutCounterX + 1
		end
		@pageLayoutPositionX = @startPositionX + @pagesLayoutCounterX*@pagesLayoutStepX
		return [x,y]
	end
	def buildForPages()
		File.open(@mm_output_path,"w") {|f|
		   f.puts(@@line1)
		   @pagesAmount.times { |n|
		      position = self.pageLayoutPosition()
		      shift = 0
		      f.puts(' <child ID="'+(n+shift).to_s+'0" label="New Node" layerID="1" created="1446528916163"')
		      f.puts(' x="'+position[0].to_s+'" y="'+position[1].to_s+'" width="'+(@pageWidth+55).to_s+'.0" height="'+(@pageHeight+38).to_s+'.0"')
		      f.puts(' strokeWidth="1.0" autoSized="true" xsi:type="node">')
		      f.puts(' <resource referenceCreated="0"')
		      f.puts(' spec="'+@pagesDirPath + @pageFilePrefix + (n+shift).to_s + @pageFileEnding +'"')
		      f.puts(' type="1" xsi:type="URLResource">')
		      f.puts(' <title>'+@pageFilePrefix + (n+shift).to_s + @pageFileEnding +'</title>')
		      f.puts(' <property key="image.width" value="'+@pageWidth.to_s+'"/>')
		      f.puts(' <property key="image.height" value="'+@pageHeight.to_s+'"/>')
		      f.puts(' <property key="image.format" value="'+@pageFileFormat+'"/>')
		      f.puts(' </resource>')
		      f.puts(' <fillColor>#FFC63B</fillColor>')
		      f.puts(' <strokeColor>#000000</strokeColor>')
		      f.puts(' <textColor>#000000</textColor>')
		      f.puts(' <font>SansSerif-plain-12</font>')
		      f.puts(' <URIString>http://vue.tufts.edu/rdf/resource/cbd958037f00000112bed12d3087ff06</URIString>')
		      f.puts(' <child ID="'+(n+shift).to_s+'1" created="1446528949173" x="34.0" y="23.0"')
		      f.puts(' width="'+(@pageWidth+16).to_s+'.0" height="'+(@pageHeight+18).to_s+'.0" strokeWidth="0.0"')
		      f.puts(' autoSized="false" xsi:type="image">')
		      f.puts(' <resource referenceCreated="0"')
		      f.puts(' spec="'+@pagesDirPath + @pageFilePrefix + (n+shift).to_s + @pageFileEnding +'"')
		      f.puts(' type="1" xsi:type="URLResource">')
		      f.puts(' <title>'+@pageFilePrefix + (n+shift).to_s + @pageFileEnding +'</title>')
		      f.puts(' <property key="image.width" value="'+@pageWidth.to_s+'"/>')
		      f.puts(' <property key="image.height" value="'+@pageHeight.to_s+'"/>')
		      f.puts(' <property key="image.format" value="'+@pageFileFormat+'"/>')
		      f.puts(' </resource>')
		      f.puts(' <fillColor>#FFFFFF</fillColor>')
		      f.puts(' <strokeColor>#404040</strokeColor>')
		      f.puts(' <textColor>#000000</textColor>')
		      f.puts(' <font>SansSerif-plain-14</font>')
		      f.puts(' <URIString>http://vue.tufts.edu/rdf/resource/cbd958047f00000112bed12d2c1b041a</URIString>')
		      f.puts(' </child>')
		      f.puts(' <shape arcwidth="20.0" archeight="20.0" xsi:type="roundRect"/>')
		      f.puts(' </child>')
		   }
		   f.puts(@@line2)
		}
	end
end

# vim: tabstop=4 softtabstop=0 noexpandtab shiftwidth=4 number
