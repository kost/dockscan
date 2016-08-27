class GetDockerVersion < Dockscan::Modules::DiscoverModule

	def info
		return 'Info discovery module'
	end

	def run
		sp=Dockscan::Scan::Plugin.new
		sp.obj = Docker.version
		sp.output = sp.obj.map{|k,v| "#{k}=#{v}"}.join("\n")
		return sp
	end
end

