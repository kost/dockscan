class DockerInsecureRegistries < AuditModule

	def info
		return 'This plugin checks if insecure registries in use'
	end

	def check(dockercheck)
		sp=ScanPlugin.new
		si=ScanIssue.new 
		si.title="Insecure registries in use"
		si.description="Docker daemon reports it is running configuration with insecure registries.\nThis is not recommended as attacker is able to deploy malicious images to registries."
		si.solution="It is recommended to use secure registries and configuration without insecure registries."
		si.severity=4 # Low
		si.risk = { "cvss" => 3.2 } 
		si.references = {"CIS" => "2.5 Do not use insecure registries" }
		sp.vuln=si	
		if scandata.key?("GetDockerInfo") and scandata["GetDockerInfo"].obj.key?("RegistryConfig")
			sp.state="run"
			vulnerable = false
			outputregs = ""
			outputindexs = ""
			# ["RegistryConfig"]["InsecureRegistryCIDRs"].each do |item| puts item end
			scandata["GetDockerInfo"].obj["RegistryConfig"]["InsecureRegistryCIDRs"].each do |item|
				if item != "127.0.0.0/8" then
					vulnerable=true
					outputregs = item << "\n"
				end
			end
			# Docker.info["RegistryConfig"]["IndexConfigs"].each do |item,value| puts item,value,value["Secure"] end
			scandata["GetDockerInfo"].obj["RegistryConfig"]["IndexConfigs"].each do |item, value|
				if value["Secure"] != true
					vulnerable=true
					outputindexs = item value["Name"] << "\n"
				end
			end

			if vulnerable then
				sp.state="vulnerable"
				sp.output = "Docker daemon reports it is using insecure registries. Offending issues below.\n "
				if outputregs != "" then
					sp.output << "Insecure CIDRs offending configuration:\n"
					sp.output << outputregs << "\n"
				end
				if outputindexs != "" then
					sp.output << "Offending registry indexes:\n"
					sp.output << outputindexs << "\n"
				end
			end
		end
		return sp
	end
end

