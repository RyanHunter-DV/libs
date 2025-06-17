require_relative 'MjsProcess'
require_relative 'MjsCommand'
require_relative '../printer'

module MultJobSystem

	@on_going_jobs=[]; # stores instance of MjsProcess
	@finished_jobs=[];
	@max_job = 10;

	def self.run(limit=0,verbo=5)
		@max_job = limit if limit > 0;
		@debug = Printer.new(verbo,:severity=>:DEBUG);
		@debug > "Initializing MultJobSystem with max jobs: #{@max_job}"
	end

	def self.max_job=(job_name)
		@max_job = job_name
		@debug > "Max jobs set to: #{@max_job}"
	end

	##dispatch the input command.
	# the command arg is instance of MjsCommand.
	def self.dispatch(job)
		@debug > "Dispatching new job"
		# 1. check current on going jobs reaches the maximum limit or not.
		# 2. if reaches the maximum limit, wait for the job to complete.
		# 3. if not reaches the maximum limit, dispatch the job.
		self.schedule();
		@debug > "Scheduling job done. Current job count: #{@on_going_jobs.size}"
		return self.submit(job);
	end

	# arrange the incoming command argument, with given options, generate to MjsCommand instance
	def self.submit(job)
		@debug > "Submitting new job"
		p=MjsProcess.new(job);
		p.start();
		@on_going_jobs << p;
		@debug > "Job submitted. Current job count: #{@on_going_jobs.size}"
		return p;
	end

	def self.wait_job_finish(num=1)
		# Wait for specified number of jobs to finish
		initial_size = @on_going_jobs.size
		target_size = initial_size - num
		@debug > "Waiting for #{num} jobs to finish. Initial size: #{initial_size}, Target size: #{target_size}"
		
		while @on_going_jobs.size > target_size
			@debug > "Current jobs size: #{@on_going_jobs.size}"
			@on_going_jobs.each do |job|
				@debug > "Checking job status: #{job.get_status}"
				status = job.get_status
				if status == :finished || status == :killed
					@debug > "Removing #{status} job: #{job.job_id}"
					@finished_jobs << job;
					@on_going_jobs.delete(job)
				end
			end
			sleep(5)
		end
		@debug > "Finished waiting for jobs. Final size: #{@on_going_jobs.size}"
	end

	def self.schedule()
		@debug > "Scheduling jobs. Current count: #{@on_going_jobs.size}, Max jobs: #{@max_job}"
		if @on_going_jobs.size >= @max_job
			puts ("Maximum jobs reached, waiting for one job to finish")
			self.wait_job_finish(1)
		end
	end

end
