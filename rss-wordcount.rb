#!/usr/bin/ruby

require 'rss/1.0'
require 'rss/2.0'
require 'pp'

url = "http://www.nrk.no/nyheiter/toppsaker.rss"
rss = RSS::Parser.parse(open(url).read, false)
text = ""
rss.items.each { |i| 
    text += i.title + " " + i.description + " "
}
words = Hash.new
text.split(/[ .,]/).each { |w|
    if words.has_key?(w)
	words[w] += 1
    else 
	words[w] = 1
    end
}
words.delete("")
occurrences = words.sort { |a,b| 
    b[1] <=> a[1] 
}
occurrences[0..9].each { |w|
    printf("%s -> %d\n", w[0], w[1])
}
