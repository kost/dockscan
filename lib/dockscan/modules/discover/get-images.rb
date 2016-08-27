require 'docker'

class GetImages < Dockscan::Modules::DiscoverModule

	def info
		return 'Image discovery module'
	end

	def run
		sp=Dockscan::Scan::Plugin.new
		sp.obj = Docker::Image.all
		sp.output = sp.obj.map{|k,v| "#{k}=#{v}"}.join("\n")
		return sp
	end
end

