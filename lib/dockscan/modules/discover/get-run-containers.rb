class GetContainersRunning < Dockscan::Modules::DiscoverModule

	def info
		return 'Running Container discovery module'
	end

	def run
		sp=Dockscan::Scan::Plugin.new
		sp.obj = Docker::Container.all
		sp.output = sp.obj.map{|k,v| "#{k}=#{v}"}.join("\n")
		return sp
	end
end

