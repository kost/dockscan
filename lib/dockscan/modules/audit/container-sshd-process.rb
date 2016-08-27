class ContainerSSHProcess < AuditModule

	def info
		return 'This plugin checks if SSH is running inside container'
	end

	def check(dockercheck)
		sp=ScanPlugin.new
		si=ScanIssue.new 
		si.title="Container have SSH server process"
		si.description="Docker daemon reports it is running SSH daemon inside container.\nThis is not recommended practice as it provides yet another attack surface for attackers and wastes computer resources."
		si.solution="It is recommended to remove SSH daemon/client from container. It is recommended to use docker exec command to execute commands inside container."
		si.severity=4 # Low
		si.risk = { "cvss" => 3.2 } 
		sp.vuln=si	
		sp.output=""
		if scandata.key?("GetContainersRunning") and not scandata["GetContainersRunning"].obj.empty?
			sp.state="run"
			scandata["GetContainersRunning"].obj.each do |container|
				ps=container.top
				ps.each do |process|
					if process["CMD"].include?("ssh") then
						sp.output << idcontainer(container) << " has SSH process running: " << process["CMD"] << "\n"
						sp.state="vulnerable"
						break
					end
				end
			end
		end
		return sp
	end
end

