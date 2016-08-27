require './scan/scan-issue.rb'

class ScanPlugin
	attr_accessor :state, :output, :obj, :vuln, :cname

	def initialize
		state="untested"
		vuln = ScanIssue.new
	end
end
