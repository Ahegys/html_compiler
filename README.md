<div align="center">
  <h1>HTML Tag Modifier</h1>
  <p>
    A Ruby project for modifying HTML tags in an HTML file.
  </p>
  <p>
    <a href="#about">About</a> •
    <a href="#features">Features</a> •
    <a href="#getting-started">Getting Started</a> •
    <a href="#usage">Usage</a> •
    <a href="#contributing">Contributing</a> •
    <a href="#license">License</a>
  </p>
  <br>
</div>

## About

HTML Tag Modifier is a Ruby project that provides a convenient way to modify and create HTML tags within an HTML file. It allows you to update the content and attributes of specific tags or create new tags with custom content and attributes. It simplifies the process of manipulating HTML files programmatically.

## Features

- Modify the content and attributes of HTML tags within an HTML file.
- Create new HTML tags with custom content and attributes.
- Find tags based on their ID or class name.

## Getting Started

To get started with HTML Tag Modifier, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/Ahegys/html_compiler.git
    ```
2. Install the required dependencies:
    ```bash
        -- Mac: brew install ruby
        -- Arch: sudo pacman -Syyuu ruby
        -- Debian/bases: sudo apt install ruby
        -- openSuse: zypper install ruby
    ```
3. Customize and configure the project as needed.

## Usage

1. Import the HTMLTagModifier class into your Ruby script:
    ```ruby
        require_relative 'HTMLTagModifier'
    ```
2. Create an instance of HTMLTagModifier with the path to your HTML file:
    ```ruby
        modifier = HTMLTagModifier.new('path/to/your/file.html')
    ```
3. Use the available methods to modify or create HTML tags:
    ```ruby
        # Modify an existing tag
        modifier.modify_tag('h1', 'New title')
    ```

# Create a new tag
```ruby
modifier.create_tag('div', 'New div', { id: 'my-div', class: 'container' })
```

# Find tags by ID
```ruby
matches_by_id = modifier.find_by_id('my-div')
if matches_by_id
  matches_by_id.each do |tag|
    puts tag
  end
else
  puts "No tags with the ID 'my-div' found."
end
```

# Find tags by class name
```ruby
matches_by_class = modifier.find_by_class('highlight')
if matches_by_class
  matches_by_class.each do |tag|
    tag.update_content('Updated paragraph') if tag
  end
else
  puts "No tags with the class 'highlight' found."
end
```
# Display the updated content of the HTML file
```ruby
puts File.read('path/to/your/file.html')
```
4.  Customize the code to fit your specific requirements.
```ruby
  modifier.modify_tag('h2', File.read(ARGV[0]), { id: 'newName', class: 'container' })
  modifier.create_tag('style', File.read(ARGV[1]))
  # this must read the file specified in the argv, in this case we use the txt that has html and css tags
```
#### execute
```bash
ruby srcs/compiler.rb ./main.txt css.txt
```
## License
This project is licensed under the MIT License.
