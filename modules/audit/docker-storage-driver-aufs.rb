require 'scan/scan-issue'
require 'pry'

class DockerStorageDriverAufs < AuditModule

	def info
		return 'This plugin checks if storage driver is aufs'
	end

	def check(dockercheck)
		sp=ScanPlugin.new
		si=ScanIssue.new 
		si.title="Running aufs as storage driver"
		si.description="Docker daemon reports it is running aufs as storage driver.\nThis is not recommended for production as it might have problems and security issues."
		si.solution="It is recommended to use devicemapper instead of aufs storage driver. Actually, you should use the storage driver that is best supported by your vendor."
		si.severity=4 # Low
		si.risk = { "cvss" => 3.2 } 
		si.reflinks = {"Switching Docker from aufs to devicemapper" => "http://muehe.org/posts/switching-docker-from-aufs-to-devicemapper/"}
		si.references = {"CIS" => "2.7 Do not use the aufs storage driver" }
		sp.vuln=si	
		if scandata.key?("GetDockerInfo") and scandata["GetDockerInfo"].obj.key?("Driver")
			sp.state="run"
			if scandata["GetDockerInfo"].obj["Driver"] == true then
				sp.output = "Docker daemon reports it is running aufs as storage driver."
				sp.state="vulnerable"
			end
		end
		return sp
	end
end

