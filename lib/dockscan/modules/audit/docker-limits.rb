class DockerLimits < Dockscan::Modules::AuditModule

	def info
		return 'This plugin checks if docker is running with defined limits'
	end

	def check(dockercheck)
		sp=Dockscan::Scan::Plugin.new
		si=Dockscan::Scan::Issue.new
		si.title="Docker running without defined limits"
		si.description="Docker daemon reports it is running daemon without defined limits.\nThis is not recommended as offending containers could use up all resources."
		si.solution="It is recommended to define docker limits."
		si.severity=5 # Medium
		si.risk = { "cvss" => 4.4 } 
		si.references = {"CIS" => "2.10 Set default ulimit as appropriate" }
		sp.output=""
		sp.vuln=si	
		if scandata.key?("GetDockerInfo") and scandata["GetDockerInfo"].obj.key?("MemoryLimit")
			sp.state="run"
			if scandata["GetDockerInfo"].obj["MemoryLimit"] == false then
				sp.output << "Docker daemon reports it is running without memory limit.\n"
				sp.state="vulnerable"
			end
		end
		if scandata.key?("GetDockerInfo") and scandata["GetDockerInfo"].obj.key?("SwapLimit")
			if scandata["GetDockerInfo"].obj["SwapLimit"] == false then
				sp.output << "Docker daemon reports it is running without swap limit.\n"
				sp.state="vulnerable"
			end
		end
		return sp
	end
end

