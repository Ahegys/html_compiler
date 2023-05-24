class Tag
	attr_accessor :content

	# Initializes a Tag instance with the provided tag string
	def initialize(tag_string)
	@tag_string = tag_string
	@content = extract_content
	end

	# Updates the content of the tag with the new content
	def update_content(new_content)
	@tag_string.sub!(@content, new_content) if @content
	@content = new_content
	end

	# Returns a string representation of the tag
	def to_s
	@tag_string
	end

	private

	# Extracts the content from the tag string
	def extract_content
	regex = />([^<]*)</
	match = @tag_string.match(regex)
	match ? match[1] : nil
	end
end
