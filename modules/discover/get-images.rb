require 'docker'

class GetImages < DiscoverModule

	def info
		return 'Image discovery module'
	end

	def run
		sp=ScanPlugin.new
		sp.obj = Docker::Image.all
		sp.output = sp.obj.map{|k,v| "#{k}=#{v}"}.join("\n")
		return sp
	end
end

