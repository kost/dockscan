class GetDockerVersion < DiscoverModule

	def info
		return 'Info discovery module'
	end

	def run
		sp=ScanPlugin.new
		sp.obj = Docker.version
		sp.output = sp.obj.map{|k,v| "#{k}=#{v}"}.join("\n")
		return sp
	end
end

