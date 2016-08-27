require 'docker'

class GetDockerInfo < DiscoverModule

	def info
		return 'Info discovery module'
	end

	def run
		sp=ScanPlugin.new
		sp.obj = Docker.info
		sp.output = sp.obj.map{|k,v| "#{k}=#{v}"}.join("\n")
		sp.state = "run"
		return sp
	end
end

