class ScanIssue
	attr_accessor :severity, :description, :solution, :title, :tags, :references, :risk, :reflinks

	def initialize
		severity=0
		description="Forgot to add description"
		solution="Information only."
		title="Forgot to add title"
		tags=Hash.new
		references=Hash.new
		risk=Hash.new
		reflinks=Hash.new
	end
end
