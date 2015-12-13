class ReportStdout < ReportModule

	def info
		return 'This plugin produces brief stdout reports'
	end

	def format
		return "stdout"
	end
	
	def file_extension
		return "-stdout.txt"
	end	

	def report(opts)
		output=""
		output << "Dockscan Report\n\n"
		
		issues = sortvulns
		7.downto(3) do |sev|
			if issues.key?(sev)
				output << sev2word(sev) << "\n"
				issues[sev].each do |v|
					# output << k << ": "
					output << v.vuln.title << ": "
					output << v.vuln.solution
					# output << v.output 
					output << "\n"
				end
				output << "\n"
			end
		end
		return output
	end
end

