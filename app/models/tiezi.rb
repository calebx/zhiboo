require 'nokogiri'
require 'open-uri'
class Tiezi < ActiveRecord::Base
  #@url = ""
	#@lz = ""
  #@title = ""
	attr_accessor :pages
	#@tiezi = {}
  #@reply_num

	def create(u)
		@url = u
  end

	def chk_url
		result = ""
		regEx = /douban\.com\/group\/topic\/[0-9]*/
		if regEx =~ @url
			result = ("http://www." << regEx.match(@url).to_s << "/")
		else
			return "www.douban.com"
		end
		@url = result
	end

	def tuoshui
		return 0 if @lz == ""
		@tiezi.each do |key,value|
			if value[0]!=@lz
				@tiezi.delete(key)			
			end
		end
	end

	def fatch_tiezi
		#url = "http://www.douban.com/group/topic/24097226/"
		doc = Nokogiri::HTML(open(@url))
		@title = doc.at_css("title").text
		@tiezi={}
		@lz = ""
		@pages = 0
		topicdoc = ""
		
		doc.css(".pl20").each do |item|
			@lz = item.at_css("a").text
		end
		doc.css(".topic-doc").each do |item|
			topicdoc=item.at_css("p").text
		end
		@tiezi[0]=[@lz,topicdoc]
		@reply_num=0
		doc.css(".reply-doc").each do |item|
			@reply_num += 1
			author = item.at_css("a").text
			content= item.at_css("p").text
			@tiezi[@reply_num] = [author, content]
		end
	end

	def next_url
		for i in 1..10
			current_replynum = @reply_num
			fatch_nextpage
			puts "---"
			puts "next is :#{i}"
			if current_replynum == @reply_num
				puts "over le "
				break
			end
		end
	end
	
	def fatch_nextpage
		@pages += 1
		u = @url + "?start=" + @pages.to_s + "00"
		puts "chk #{u}"
		doc = Nokogiri::HTML(open(u))
		doc.css(".reply-doc").each do |item|
			@reply_num += 1
			author = item.at_css("a").text
			content= item.at_css("p").text
			@tiezi[@reply_num] = [author, content]
			
		end
		puts "last reply is #{@reply_num}"
  end

	def to_something
		@tiezi
	end

end
