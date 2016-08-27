require 'dockscan/scan/issue'

module Dockscan
module Scan
class Plugin
	attr_accessor :state, :output, :obj, :vuln, :cname

	def initialize
		state="untested"
		vuln = Dockscan::Scan::Issue.new
	end
end # Plugin
end # Scan
end # Dockscan
