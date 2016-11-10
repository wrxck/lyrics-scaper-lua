--[[

	Copyright (c) 2016 wrxck

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
	of the Software, and to permit persons to whom the Software is furnished to do
	so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in all
	copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
	INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
	PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
	LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
	OR OTHER DEALINGS IN THE SOFTWARE.

--]]

function getLyrics(q)
	HTTP = require('socket.http')
	URL = require('socket.url')
	str, res = HTTP.request('http://search.azlyrics.com/search.php?q=' .. URL.escape(q))
	if res ~= 200 then
		return 'Connection error!'
	end
	search = string.match(str, 'Song results:.-1%. <a href="(.-)" target="_blank"><b>')
	if search == nil then
		return 'No results were found.'
	end
	lyrics = string.match(HTTP.request(search), '<!%-%- Usage of azlyrics%.com content by any third%-party lyrics provider is prohibited by our licensing agreement%. Sorry about that%. %-%->(.-)</div>')
	lyrics = lyrics:gsub('&quot;', '"')
	lyrics = lyrics:gsub('<br>', ''):gsub('<br >', '')
	lyrics = lyrics:gsub('&amp;', '&')
	lyrics = lyrics:gsub('<i>', ''):gsub('</i>', '')
	return lyrics
end

input = ''
for n in pairs(arg) do
	input = input .. ' ' .. arg[n]
end
input = input:gsub(arg[0], ''):gsub(arg[-1], '')

print(getLyrics(input))
