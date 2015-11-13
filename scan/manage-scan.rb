require 'docker'

require 'modules/genmodule'
require 'modules/discover'
require 'modules/audit'
require 'modules/report'

require 'scan/scanplugin'

require 'pp'

class ManageScan
attr_accessor :log

def initialize
	@auditoutput=Hash.new
	@log=Logger.new MultiDelegator.delegate(:write, :close).to(STDERR)
end

def check_connection
	@log.info("Validating version specified: "+Docker.url)
	begin
		Docker.validate_version!
	rescue
		@log.error("Error connecting or validating Docker version")
		return false
	end
	return true
end

def scan (url, opts, logger)
	failed=Array.new

	if url != nil then
		Docker.url = url
	end
	
	@log=logger
	
	if not check_connection then
		return
	end

	@log.info("Loading discovery modules...")

	Dir["./modules/discover/*.rb"].each do |f| 
		@log.info("Loading discovery module: #{f}")
		begin
			require f 
		rescue SyntaxError => se
			@log.info("Error loading audit module: #{f}")
			@log.debug("Error executing audit module: #{se.backtrace}")
			failed << f
		end
	end

	@log.info("Running discovery modules...")
	DiscoverModule.modules.each do |modclass|
		@log.info("Running discovery module: #{modclass.name}")
		begin
			mod=modclass.new
			mod.scandata=@auditoutput
			@auditoutput[mod.class.name]=mod.run
		rescue Exception => e
			@log.info("Error executing audit module: #{modclass.name}")
			@log.debug("Error executing audit module: #{e.backtrace}")
			failed << modclass.name
		end
		# pp @auditoutput[mod.class.name]
	end


	@log.info("Loading audit modules...")
	Dir["./modules/audit/*.rb"].each do |f| 
		@log.info("Loading audit module: #{f}")
		begin
			require f 
		rescue SyntaxError => se
			@log.info("Error loading audit module: #{f}")
			@log.debug("Error executing audit module: #{se.backtrace}")
			failed << f
		end
	end

	@log.info("Running audit modules...")
	AuditModule.modules.each do |modclass|
		@log.info("Running audit module: #{modclass.name}")
		begin
			mod=modclass.new
			mod.scandata=@auditoutput
			@auditoutput[mod.class.name]=mod.check('test')
		rescue Exception => e
			@log.info("Error executing audit module: #{modclass.name}")
			@log.debug("Error executing audit module: #{e.backtrace}")
			failed << modclass.name
		end
		# pp @auditoutput[mod.class.name]
	end

	@log.info("Loading report modules...")
	Dir["./modules/report/*.rb"].each do |f| 
		@log.info("Loading report #{f}")
		begin
			require f 
		rescue SyntaxError => se
			@log.info("Error loading report module: #{f}")
			@log.debug("Error executing report module: #{se.backtrace}")
			failed << f
		end
	end


	@log.info("Running report modules...")
	ReportModule.modules.each do |modclass|
		@log.info("Running report module: #{modclass.name}")
		mod=modclass.new
		if opts.key?("report") then
			formats=opts["report"].split(",")
		else
			formats=['stdout']
		end
		formats.each do |fmt|
			if fmt==mod.format then
				begin
					mod.scandata=@auditoutput
					output=mod.report(nil)
					if opts.key?("output") then
						reportfilename = opts["output"]
						reportfilename << mod.file_extension
						File.open(reportfilename, 'w') { |file| file.write(output) }
					else
						puts output	
					end
				rescue Exception => e
					@log.info("Error executing report module: #{modclass.name}")
					@log.debug("Error executing report module: #{e.backtrace}")
					failed << modclass.name
				end
				@log.debug(output)
			else
				@log.debug("Skipping report module: #{modclass.name}");
			end
		end
	end

	if failed.count > 0
		failedstr=""
		failed.each do |f|
			failedstr = f + " "
		end
		@log.warn("Following modules failed: #{failedstr}") 
	end
end

end
