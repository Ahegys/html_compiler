class HTMLSyntaxParser
	def initialize(file_path)
		@file_path = file_path
	end

	def parse
		file_content = File.read(@file_path)
		tokens = tokenize(file_content)
		syntax_tree = build_syntax_tree(tokens)
		return syntax_tree
	end

	private

	def tokenize(file_content)
		# Scans the file content using a regular expression to extract HTML tags and text
		file_content.scan(/<(\/?)(\w+).*?>|([^<]+)/m).flatten.compact
	end

	def build_syntax_tree(tokens)
		root = SyntaxNode.new('root')
		stack = [root]
		current_node = root
	
		tokens.each do |token|
			if token.start_with?('<') && !token.start_with?('</')
				tag_name = token[1..-2]
				# Create a new SyntaxNode for the HTML tag and add it as a child of the current node
				new_node = SyntaxNode.new(tag_name, current_node)
				current_node.add_child(new_node)
				current_node = new_node
	
				stack.push(current_node)
			elsif token.start_with?('</')
				tag_name = token[2..-3]
				if stack.empty? || stack.last.tag_name != tag_name
					# Raise an error if a closing tag doesn't match the last opening tag
					raise SyntaxError, "Mismatched closing tag: </#{tag_name}>"
				end
				stack.pop
				current_node = stack.last
			else
				# Create a new SyntaxNode for the text content and add it as a child of the current node
				text_node = SyntaxNode.new('#text', current_node, token.strip)
				current_node.add_child(text_node)
			end
		end
	
		if stack.size > 1
			# Raise an error if there are unclosed tags remaining in the stack
			unclosed_tags = stack[1..].reverse.map { |node| "<#{node.tag_name}>" }.join(', ')
			raise SyntaxError, "Unclosed tags: #{unclosed_tags}"
		end
	
		root
	end
end

class SyntaxNode
	attr_accessor :tag_name, :parent, :children, :content

	def initialize(tag_name, parent = nil, content = nil)
		@tag_name = tag_name
		@parent = parent
		@children = []
		@content = content
	end

	def add_child(child)
		# Add a child node to the current node by appending it to the children array
		@children << child
	end
end
