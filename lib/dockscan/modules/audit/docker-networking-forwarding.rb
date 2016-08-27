class DockerIPV4Forwarding < Dockscan::Modules::AuditModule

	def info
		return 'This plugin checks if docker is running with ipv4 forwarding enabled'
	end

	def check(dockercheck)
		sp=Dockscan::Scan::Plugin.new
		si=Dockscan::Scan::Issue.new
		si.title="Docker running with IPv4 forwarding enabled"
		si.description="Docker daemon reports it is running daemon with IPv4 forwarding enabled.\nThis is not recommended for production as it forwards network packets without rules."
		si.solution="It is recommended to disable IPv4 forwarding by default."
		si.severity=5 # Medium
		si.risk = { "cvss" => 5.0 } 
		si.reflinks = {"ip_forward to expose containers to the public internet" => "https://github.com/docker/docker/issues/11508"}
		sp.vuln=si	
		if scandata.key?("GetDockerInfo") and scandata["GetDockerInfo"].obj.key?("IPv4Forwarding")
			sp.state="run"
			if scandata["GetDockerInfo"].obj["IPv4Forwarding"] == true then
				sp.output = "Docker daemon reports it is running with automatic IPv4 forwarding."
				sp.state="vulnerable"
			end
		end
		return sp
	end
end

