require 'dockscan/scan/issue'

module Dockscan
module Scan
class Plugin
	attr_accessor :state, :output, :obj, :vuln, :cname

	def initialize
		state="untested"
		vuln = ScanIssue.new
	end
end # Plugin
end # Scan
end # Dockscan
