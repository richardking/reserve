require 'resque/tasks'
require 'resque_scheduler/tasks'

namespace :resque do
  task :setup do
    require 'resque'
    require 'resque_scheduler'
    require 'resque/scheduler'

    Resque.redis = 'localhost:6379'

    Resque.schedule = YAML.load_file(File.dirname(__FILE__) + '/../../config/resque_schedule.yml')
  end

  desc "kill all workers using QUIT"
  task :stop_workers => :environment do
    pids = Array.new

    Resque.workers.each do |worker|
      pids << worker.to_s.split(/:/).second
    end

    if pids.size > 0
     system("kill -QUIT #{pids.join(' ')}")
    end

  end 

  desc "stop scheduler"
  task :stop_scheduler => :environment do
    puts "temp holder"
    pidfile = "/service/scheduler/supervise/pid"

    if !File.exists?(pidfile)
      puts "Scheduler not running"
    else
      pid = File.read(pidfile).to_i
      system("kill -QUIT #{pid}")
  end
end
