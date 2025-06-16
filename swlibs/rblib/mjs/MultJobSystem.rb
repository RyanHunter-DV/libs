require_relative 'MjsProcess'
require_relative 'MjsCommand'

module MultJobSystem

	@on_going_jobs=[]; # stores instance of MjsProcess
	@finished_jobs=[];
	@max_job = 10;

	def self.debug_log(message)
		caller_info = caller(1).first
		message = "[#{caller_info}] #{message}"
		puts "[DEBUG] #{message}" if ENV['DEBUG_MODE'] == 'true'
	end

	def self.run(limit)
		# Initialize class variables if not already set
		@max_job ||= limit;
		debug_log("Initializing MultJobSystem with max jobs: #{@max_job}")
	end

	def self.max_job=(job_name)
		@max_job = job_name
		debug_log("Max jobs set to: #{@max_job}")
	end

	##dispatch the input command.
	# the command arg is instance of MjsCommand.
	def self.dispatch(job)
		debug_log("Dispatching new job")
		# 1. check current on going jobs reaches the maximum limit or not.
		# 2. if reaches the maximum limit, wait for the job to complete.
		# 3. if not reaches the maximum limit, dispatch the job.
		self.schedule();
		debug_log("Scheduling job done. Current job count: #{@on_going_jobs.size}")
		return self.submit(job);
	end

	# arrange the incoming command argument, with given options, generate to MjsCommand instance
	def self.submit(job)
		debug_log("Submitting new job")
		p=MjsProcess.new(job);
		p.start();
		@on_going_jobs << p;
		debug_log("Job submitted. Current job count: #{@on_going_jobs.size}")
		return p;
	end

	def self.wait_job_finish(num=1)
		# Wait for specified number of jobs to finish
		initial_size = @on_going_jobs.size
		target_size = initial_size - num
		debug_log("Waiting for #{num} jobs to finish. Initial size: #{initial_size}, Target size: #{target_size}")
		
		while @on_going_jobs.size > target_size
			debug_log("Current jobs size: #{@on_going_jobs.size}")
			@on_going_jobs.each do |job|
				debug_log("Checking job status: #{job.status}")
				if job.status == :finished || job.status == :killed
					debug_log("Removing #{job.status} job")
					@finished_jobs << job;
					@on_going_jobs.delete(job)
				end
			end
			sleep(1)
		end
		debug_log("Finished waiting for jobs. Final size: #{@on_going_jobs.size}")
	end

	def self.schedule()
		debug_log("Scheduling jobs. Current count: #{@on_going_jobs.size}, Max jobs: #{@max_job}")
		if @on_going_jobs.size >= @max_job
			debug_log("Maximum jobs reached, waiting for one job to finish")
			self.wait_job_finish(1)
		end
	end

end
