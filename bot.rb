require 'telegram/bot' 
require 'uri'
require 'net/http'
#require 'rosemary'

#node_finder = Rosemary::Api.new()



token = ENV['TELEGRAM_BOT_TOKEN']
raise "No Telegram bot token provided in TELEGRAM_BOT_TOKEN env var" if token.nil? || token.empty?

Telegram::Bot::Client.run(token) do |bot|
 bot.listen do |msg|
  if msg.text == "/help"
   bot.api.send_message(chat_id: msg.chat.id, text: "Send me a keyword, I'll give you the link")
  elsif msg.text == "/about"
   bot.api.send_message(chat_id: msg.chat.id, text: "This is an OSM client, which helps you to find the location you want on the map")
  elsif msg.text == "/developer"
   bot.api.send_message(chat_id: msg.chat.id, text: " Programmed by Muhammadreza Haghiri
Weblog: Haghiri75.com
Twitter : prpe26
Telegram Channel: @rubymaps")
  elsif msg.text == "/start"
   bot.api.send_message(chat_id: msg.chat.id, text: "Give me a keyword, I search on OSM for you")
  elsif msg.text == "/stop"
   bot.api.send_message(chat_id: msg.chat.id, text: "Bye Bye!")
  else
   uri = URI.parse("http://nominatim.openstreetmap.org/search?q=#{URI.encode(msg.text)}")
   response = Net::HTTP.get_response(uri)
   if response.body.include? "No search results found"
   bot.api.send_message(chat_id: msg.chat.id, text:"Unfortunately, There is no place #{msg.text} submitted on the maps")
   else
   bot.api.send_message(chat_id: msg.chat.id, text: "This place is submitted on http://openstreetmap.org/search?query=#{msg.text.gsub(' ', '+')}") 
   end
  end
 end 
end
