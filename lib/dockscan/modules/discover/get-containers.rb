class GetContainers < Dockscan::Modules::DiscoverModule

	def info
		return 'Container discovery module'
	end

	def run
		sp=Dockscan::Scan::Plugin.new
		sp.obj = Docker::Container.all(:all => true)
		sp.output = sp.obj.map{|k,v| "#{k}=#{v}"}.join("\n")
		return sp
	end
end

