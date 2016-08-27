class DockerRegistryMirror < Dockscan::Modules::AuditModule

	def info
		return 'This plugin checks if mirror registries are in use'
	end

	def check(dockercheck)
		sp=Dockscan::Scan::Plugin.new
		si=Dockscan::Scan::Issue.new
		si.title="Docker registries are not mirrored"
		si.description="Docker daemon reports it is running configuration without registry mirrors.\nIf you set up local mirror, your docker host does not have to go directly to internet if not needed."
		si.solution="It is recommended to setup mirror registry."
		si.severity=4 # Low
		si.risk = { "cvss" => 3.0 } 
		si.references = {"CIS" => "2.6 Setup a local registry mirror" }
		sp.vuln=si	
		if scandata.key?("GetDockerInfo") and scandata["GetDockerInfo"].obj.key?("RegistryConfig")
			sp.state="run"
			vulnerable=true
			outputindexs = ""
			scandata["GetDockerInfo"].obj["RegistryConfig"]["IndexConfigs"].each do |item, value|
				if value["Mirrors"] != nil
					vulnerable = false
				else
					outputindexs << value["Name"] << "\n"
				end
			end

			if vulnerable then
				sp.state="vulnerable"
				sp.output = "Docker daemon reports it does not have mirror registries.\n"
				if outputindexs != "" then
					sp.output << "Offending registry indexes:\n"
					sp.output << outputindexs << "\n"
				end
			end
		end
		return sp
	end
end

