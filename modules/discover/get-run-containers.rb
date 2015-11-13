class GetContainersRunning < DiscoverModule

	def info
		return 'Running Container discovery module'
	end

	def run
		sp=ScanPlugin.new
		sp.obj = Docker::Container.all
		sp.output = sp.obj.map{|k,v| "#{k}=#{v}"}.join("\n")
		return sp
	end
end

