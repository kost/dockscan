class ContainerFilesystemDiff < AuditModule

	def info
		return 'This plugin checks for filesystem differences'
	end

	def check(dockercheck)

		limit=5
		sp=ScanPlugin.new
		si=ScanIssue.new 
		si.title="Container have higher number of changed files"
		si.description="Container have high number of changed files which is not recommended practice.\nThis is not recommended for production as data can be lost. It can also mean successful break in attempt."
		si.solution="It is recommended to have minimal number of changed files inside container and do not store data inside container. It is recommended to use volumes."
		si.severity=4 # Low
		si.risk = { "cvss" => 3.2 } 
		sp.vuln=si	
		sp.output=""
		if scandata.key?("GetContainers") and not scandata["GetContainers"].obj.empty?
			sp.state="run"
			scandata["GetContainers"].obj.each do |container|
				begin
					ps=container.changes
					if ps.count > limit then
						sp.state="vulnerable"
						allch = ''
						ps.each do |change|
							allch << change["Path"] << "\n"
						end
						sp.output << idcontainer(container) << " has more than #{limit} file changes: #{ps.count}\n"
						sp.output << allch
						sp.output << "\n"
					end
				rescue
				end
			end
		end
		return sp
	end
end

