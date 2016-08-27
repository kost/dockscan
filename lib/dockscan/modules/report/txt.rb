class ReportText < ReportModule

	def info
		return 'This plugin produces text reports'
	end

	def format
		return "txt"
	end
	
	def file_extension
		return ".txt"
	end	

	def report(opts)
		output=""
		output << "Dockscan Report\n\n"
		
		issues = sortvulns
		7.downto(3) do |sev|
			if issues.key?(sev)
				output << "-[ " << sev2word(sev) << " ]-\n"
				issues[sev].each do |v|
					output << "=" << v.vuln.title << "=\n"
					output << "Description:\n" << v.vuln.description << "\n"
					output << "Output:\n" << v.output << "\n" 
					output << "Solution:\n" << v.vuln.solution << "\n"
					output << "\n"
				end
				output << "\n"
			end
		end
		return output
	end
end

