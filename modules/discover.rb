class DiscoverModule < GenericModule
	attr_accessor :scandata
	def info
		raise "#{self.class.name} doesn't implement `handle_command`!"
	end

	def run
		raise "#{self.class.name} doesn't implement `handle_command`!"
	end
end
