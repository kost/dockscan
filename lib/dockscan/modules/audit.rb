module Dockscan
module Module

class AuditModule < GenericModule
	attr_accessor :scandata

	def info
		raise "#{self.class.name} doesn't implement `handle_command`!"
	end

	def idcontainer(container)
		str=''
		str << container.id
		str << " ("
		names = ''
		container.info["Names"].each do |name|
			names << name << " "
		end
		str << names
		str << ")"
		str << " with IP: "
		str << container.json["NetworkSettings"]["IPAddress"]
		return str
	end

	def check(dockercheck)
		raise "#{self.class.name} doesn't implement `handle_command`!"
	end
end # class

end # Module
end # Dockscan
