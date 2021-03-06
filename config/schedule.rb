# Use this file to easily define all of your cron jobs.
#
# The api_queue run that hits the crunchbase api could take up to 3 days to run
#
# As a failsafe we are setting the staging cron to run every wednesday and to
# use the archived data instead of hitting the crunchbase api

set :output, 'log/cron.log'

# The crons can't find the local copies of bundle and rake so we need to use the absolute path
# Here is the custom command to do so.
cmd = 'cd :path && RAILS_ENV=:environment /usr/local/bin/bundle exec /usr/local/bin/rake :task --silent :output'
job_type :rake_with_full_path, cmd

# On production pull the data from the crunchbase api, archive it, and cache it
# every :sunday, :at => '12am' do
#   rake "api_queue:run", :environment => 'production'
# end
#
# On staging read the data from the archive and cache it

# @environment gets passed from capistrano
if @environment == 'production'
  every :sunday, at: '12am' do
    rake_with_full_path 'api_queue:run'
  end
else
  # This is what we want live
  every :wednesday, at: '12am' do
    rake_with_full_path 'api_queue:run[20,s3]'
  end

  # This is for testing
  # every 10.minutes do
  #   rake_with_full_path 'api_queue:upload_data'
  # end
end

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end
#
# An example with a custom rake path
# cmd = "cd :path && RAILS_ENV=:environment /usr/local/bin/bundle exec /usr/local/bin/rake :task --silent :output"
# job_type :rake_with_full_path, cmd

# Learn more: http://github.com/javan/whenever
