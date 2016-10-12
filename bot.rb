require 'telegram/bot' 
require 'rosemary'

node_finder = Rosemary::Api.new()

token = ''

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

  else
   bot.api.send_message(chat_id: msg.chat.id, text: "http://openstreetmap.org/search?query=#{msg.text.gsub(' ', '+')}")
  end
 end 
end
