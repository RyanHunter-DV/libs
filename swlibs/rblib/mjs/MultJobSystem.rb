require 'MjsProcess'
require 'MjsCommand'
# the debug comes from a common debug list, which can support display or record to file log.
require 'debug' 

module MultJobSystem

	@on_going_jobs=[]; # stores instance of MjsProcess
	@max_job = 10;
	@debug = Debug.new(true);

	def self.run(limit)
		# Initialize class variables if not already set
		@max_job ||= limit;
	end

	def self.max_job=(job_name)
		@max_job = job_name
	end
	##dispatch the input command.
	# the command arg is instance of MjsCommand.
	def self.dispatch(command)
		# 1. check current on going jobs reaches the maximum limit or not.
		# 2. if reaches the maximum limit, wait for the job to complete.
		# 3. if not reaches the maximum limit, dispatch the job.
		self.schedule();
	end

	def self.wait_job_finish(num=1)
		# Wait for specified number of jobs to finish
		initial_size = @on_going_jobs.size
		target_size = initial_size - num
		@debug > "Waiting for #{num} jobs to finish. Initial size: #{initial_size}, Target size: #{target_size}"
		
		while @on_going_jobs.size > target_size
			@debug > "Current jobs size: #{@on_going_jobs.size}"
			@on_going_jobs.each do |job|
				@debug > "Checking job status: #{job.status}"
				if job.status == 'FINISHED' || job.status == 'KILLED'
					@debug > "Removing #{job.status} job"
					@on_going_jobs.delete(job)
				end
			end
			sleep(1)
		end
		@debug > "Finished waiting for jobs. Final size: #{@on_going_jobs.size}"
	end


	def self.schedule()
		if @on_going_jobs.size >= @max_job
			self.wait_job_finish(1)
		end

	end




end


