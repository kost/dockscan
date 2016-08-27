module Dockscan
module Modules

class ReportModule < GenericModule
	attr_accessor :scandata

	def info
		raise "#{self.class.name} doesn't implement `handle_command`!"
	end

	def desc(item)
		if item.vuln.description
			return item.vuln.description
		else
			return false
		end
	end

	def sortvulns
		severity_sorted=Hash.new
		scandata.each do |classname,scanissue|
			if scanissue.state == "vulnerable" or scanissue.state=="info" then
				severity_sorted[scanissue.vuln.severity] ||= []
				severity_sorted[scanissue.vuln.severity] << scanissue
			end
		end
		return severity_sorted
	end

	def format
		return "unknown"
	end

	def file_extension
		return ".unknown"
	end

	def getkey(hsh,hkey)
		if hsh.has_key?(hkey) then
			return hsh[hkey]
		else
			return ''
		end
	end
	
	def sev2word(sev)
		case sev
			when	7
				return "Critical"
			when 	6
				return "High"
			when	5
				return "Medium"
			when	4
				return "Low"
			when	3
				return "Info"
			when	2
				return "Verbose"
			when	1
				return "Inspect"
			when	0
				return "Debug"
			else
				return "DebugMiss"
		end
	end

	def report(opts)
		raise "#{self.class.name} doesn't implement `handle_command`!"
	end
end # Class

end # Module
end # Dockscan
