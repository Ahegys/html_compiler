require_relative 'HTML/HTMLTagModifier'
require_relative 'HTML/Tag'

# Create an instance of HTMLTagModifier with the file path
modifier = HTMLTagModifier.new('index.html')
modifier.test_syntax_parser

# Test the modify_tag function
modifier.modify_tag('h1', 'New title')
modifier.modify_tag('p', 'Modified paragraph', { class: 'updated' })

# Test the create_tag function
modifier.create_tag('div', 'New div', { id: 'nomes', class: 'container' })

# Test the find_by_id function
matches_by_id = modifier.find_by_id('nomes')

if matches_by_id
  puts "===========[TAG]=============="
  puts matches_by_id
  puts '============================'
else
  puts "No tag with ID #{matches_by_id} found."
end

# Test the find_by_class function
matches_by_class = modifier.find_by_class('highlight')
if matches_by_class
  matches_by_class.each do |tag|
    tag.update_content('Updated paragraph') if tag
  end
else
  puts "No tag with class 'highlight' found."
end

# if you pass File.read(ARGV.first)
# you can pass a file of any document he can write

modifier.modify_tag('h2', File.read(ARGV[0]), { id: 'newName', class: 'container' })
modifier.create_tag('style', File.read(ARGV[1]))

matches_by_id = modifier.find_by_class("newName")
puts matches_by_id