require_relative "HTMLSyntaxParser"

class HTMLTagModifier
	def initialize(file_path)
		@file_path = file_path
	end

	# Modifies the content of a specified tag in the HTML file
	def modify_tag(tag_to_modify, new_content, attributes = {})
		file_content = File.read(@file_path)

		opening_tag = "<#{tag_to_modify}"
		closing_tag = "</#{tag_to_modify}>"
		opening_index = file_content.index(opening_tag)
		closing_index = opening_index ? file_content.index(closing_tag, opening_index) : nil

		if opening_index && closing_index
			tag_content = file_content[opening_index...closing_index + closing_tag.length]
			updated_tag = build_tag(tag_to_modify, new_content, attributes)
			new_file_content = file_content.gsub(tag_content, updated_tag)

			File.write(@file_path, new_file_content)

			puts "The content of the <#{tag_to_modify}> tag has been successfully updated."
		else
			puts "Error: Tag #{tag_to_modify} not found."
		end
	end

	# Creates a new tag in the HTML file
	def create_tag(tag_to_create, content, attributes = {})
		file_content = File.read(@file_path)
		tag_exists = file_content.include?("<#{tag_to_create}")

		if tag_exists
			puts "The <#{tag_to_create}> tag already exists in the file."
		else
			opening_body_tag = "<body>"
			closing_body_tag = "</body>"
			opening_index = file_content.index(opening_body_tag)
			closing_index = file_content.index(closing_body_tag)

			if opening_index && closing_index
				insertion_index = closing_index
				new_tag = "\n#{build_tag(tag_to_create, content, attributes)}\n"
				new_file_content = "#{file_content[0...insertion_index]}#{new_tag}#{file_content[insertion_index..-1]}"
			else
				new_tag = "#{build_tag(tag_to_create, content, attributes)}"
				new_file_content = "#{file_content}#{new_tag}"
			end

			File.write(@file_path, new_file_content)

			puts "The <#{tag_to_create}> tag has been created successfully."
		end
	end

	# Finds tags in the HTML file based on the provided ID
	def find_by_id(id)
		file_content = read_file_content
		regex = /<[^>]*id\s*=\s*['"]#{id}['"][^>]*>.*?<\/[^>]*>/
		matches = file_content.scan(regex)
		tag_contents = matches.map { |match| Tag.new(match.gsub(/\n/, "")) } unless matches.empty?
	end

	# Finds tags in the HTML file based on the provided class name
	def find_by_class(class_name)
		file_content = read_file_content
		regex = /<[^>]*class\s*=\s*['"]([^'"]*\s+)?#{class_name}(\s+[^'"]*)?['"][^>]*>/
		matches = file_content.scan(regex)
		tag_contents = matches.map { |match| Tag.new(match[0].gsub(/\n/, "")) if match[0] } unless matches.empty?
	end

	def test_syntax_parser
		parser = HTMLSyntaxParser.new(@file_path)
		syntax_tree = parser.parse
		puts syntax_tree
		print_syntax_tree(syntax_tree)
	end

	def print_syntax_tree(node, indent = '')
		if node.tag_name == '#text'
			puts "#{indent}#{node.content}"
		else
			puts "#{indent}<#{node.tag_name}>"
			node.children.each do |child|
				print_syntax_tree(child, indent + '  ')
			end
			puts "#{indent}</#{node.tag_name}>"
		end
	end
	
	private

	# Builds a string representation of an HTML tag with the specified content and attributes
	def build_tag(tag, content, attributes)
		tag_string = "<#{tag}"
		attributes_string = attributes.map { |key, value| " #{key}='#{value}'" }.join("")
		tag_string += attributes_string
		tag_string += ">#{content}</#{tag}>"
		tag_string
	end
	# Reads the content of the HTML file
	def read_file_content
		File.read(@file_path)
	end
end
