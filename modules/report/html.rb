class ReportHTML < ReportModule

	def info
		return 'This plugin produces HTML reports'
	end
	
	def file_extension
		return ".html"
	end

	def format
		return "html"
	end

	def htmlhead
		htmlout = ""
		htmlout << "<HTML><HEAD><TITLE>dockscan Report</TITLE></HEAD></HTML>\n"
		htmlout << "<BODY>\n"
		return htmlout
	end

	def htmlfoot
		htmlout = ""
		htmlout << "</BODY>\n"
		htmlout << "</HTML>\n"
		return htmlout
	end

	def report(opts)
		output=""
		output << htmlhead
		output << "<h2>dockscan Report<h2>"
		scandata.each do |k,v| 
			if v.state=="vulnerable" then
				output << "<TABLE>\n"
				output << "<TR>\n"
				output << "<TD COLSPAN=2>" << v.vuln.title << "</TD>\n"
				output << "<TD>" << sev2word(v.vuln.severity) << "</TD>\n"
				output << "</TR>"
				output << "<TR><TD COLSPAN=3>" << v.vuln.description << "</TD></TR>\n"
				output << "<TR><TD COLSPAN=3>" << v.vuln.solution << "</TD></TR>\n"
				output << "<TR><TD>CVSS:</TD><TD>#{k}</TD><TD>Else</TD></TR>\n"
				output << "</TABLE>\n\n"
			end
		end
		output << htmlfoot
		return output
	end
end

