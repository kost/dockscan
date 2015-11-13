class ContainerNumberProcess < AuditModule

	def info
		return 'This plugin checks if storage driver is aufs'
	end

	def check(dockercheck)
		sp=ScanPlugin.new
		si=ScanIssue.new 
		si.title="Container have higher number of processess"
		si.description="Docker daemon reports it is running aufs as storage driver.\nThis is not recommended for production as it might have problems and security issues."
		si.solution="It is recommended to have single process inside container. If you have more than one process, it is recommended to split them in separate containers."
		si.severity=4 # Low
		si.risk = { "cvss" => 3.2 } 
		sp.vuln=si	
		sp.output=""
		if scandata.key?("GetContainersRunning") and not scandata["GetContainersRunning"].obj.empty?
			sp.state="run"
			scandata["GetContainersRunning"].obj.each do |container|
				ps=container.top
				if ps.count > 1 then
					sp.state="vulnerable"
					sp.output << "More than 1 process in #{container.id}: #{ps.count}\n"
					ps.each do |process|
						sp.output << process["CMD"] << "\n"
					end
					sp.output << "\n"
				end
			end
		end
		return sp
	end
end

