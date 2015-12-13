class ContainerFileSystemShadow < AuditModule

	def info
		return 'This plugin checks /etc/shadow for problems'
	end

	def check(dockercheck)
		sp=ScanPlugin.new
		si=ScanIssue.new 
		si.title="Container have passwordless users in shadow"
		si.description="Container have vulnerable entries in /etc/shadow.\nIt allows attacker to login or switch to user without password."
		si.solution="It is recommended to set password for user or to lock user account."
		si.severity=6 # High
		si.risk = { "cvss" => 7.5 } 
		sp.vuln=si	
		sp.output=""
		if scandata.key?("GetContainers") and not scandata["GetContainers"].obj.empty?
			sp.state="run"
			scandata["GetContainers"].obj.each do |container|
				content=''
				container.copy('/etc/shadow') { |chunk| content=content+chunk }
				shcontent=''
				Gem::Package::TarReader.new(StringIO.new(content)) { |t| shcontent=t.first.read }
				# shcontent.split("\n").each do |line|
				shcontent.lines.map(&:chomp).each do |line|
					shfield=line.split(":")
					if shfield[1].to_s=='' then
						sp.state="vulnerable"
						sp.output << idcontainer(container) << " does not have password set for user: #{shfield[0]}\n"
					end
				end
			end
		end
		return sp
	end
end

