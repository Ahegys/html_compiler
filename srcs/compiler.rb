require_relative 'HTML/HTMLTagModifier'
require_relative 'HTML/Tag'

# Create an instance of HTMLTagModifier with the file path
modifier = HTMLTagModifier.new('index.html')

# Test the modify_tag function
modifier.modify_tag('h1', 'New title')
modifier.modify_tag('p', 'Modified paragraph', { class: 'updated' })

# Test the create_tag function
modifier.create_tag('div', 'New div', { id: 'my-div', class: 'container' })

# Test the find_by_id function
matches_by_id = modifier.find_by_id('my-div')
if matches_by_id
  puts "===========[TAG]=============="
  puts matches_by_id
  puts '============================'
else
  puts "No tag with ID 'my-div' found."
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

# Display the updated content of the HTML file
puts File.read('index.html')
