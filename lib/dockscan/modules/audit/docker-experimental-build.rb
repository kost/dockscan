class DockerExperimentalBuild < Dockscan::Modules::AuditModule

	def info
		return 'This plugin checks if docker is running Experimental Build'
	end

	def check(dockercheck)
		sp=Dockscan::Scan::Plugin.new
		si=Dockscan::Scan::Issue.new
		si.title="Running Experimental version of Docker."
		si.description="Docker daemon reports it is running ExperimentalBuild.\nThis is not recommended for production as it might have problems and security issues."
		si.solution="It is recommended to replace Docker version with stable and production ready one."
		si.severity=6 # High
		si.risk = { "cvss" => 7.0 } 
		si.reflinks = {"Docker's Experimental Binary" => "https://blog.docker.com/2015/06/experimental-binary/"}
		sp.vuln=si	
		if scandata.key?("GetDockerInfo") and scandata["GetDockerInfo"].obj.key?("ExperimentalBuild")
			sp.state="run"
			if scandata["GetDockerInfo"].obj["ExperimentalBuild"] == true then
				sp.output = "Docker daemon reports it is running ExperimentalBuild."
				sp.state="vulnerable"
			end
		end
		return sp
	end
end

