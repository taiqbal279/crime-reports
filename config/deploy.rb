# config valid for current version and patch releases of Capistrano
lock "~> 3.16.0"

set :application, "ifarmer_mango_tracker"
set :repo_url, "git@gitlab.com:tech-ifarmer/mango-tracking.git"
set :user,            'ubuntu'
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :staging
set :rails_env,       :staging
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_error_log, "#{release_path}/log/puma_error.log"
set :puma_access_log,  "#{release_path}/log/puma_access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/mango_track_dev.pem) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord

set :rvm_type, :ubuntu

## Defaults:
# set :scm,           :git
set :branch,        :development
# set :format,        :pretty
# set :log_level,     :debug
set :keep_releases, 5

## Linked Files & Directories (Default None):
set :linked_files, %w[config/application.yml config/database.yml config/secret_keys.yml config/secrets.yml]

set(
 :linked_dirs,
 %w[log tmp/pids tmp/states tmp/sockets tmp/cache vendor/bundle storage public/uploads]
)

# To notify deployments on slack!


# set :slackistrano, false

namespace :puma do
	desc 'Create Directories for Puma Pids and Socket'
	task :make_dirs do
		on roles(:app) do
			execute "mkdir #{shared_path}/tmp/sockets -p"
			execute "mkdir #{shared_path}/tmp/pids -p"
		end
	end
	
	before :start, :make_dirs
end

namespace :deploy do
	desc "Make sure local git is in sync with remote."
	task :check_revision do
		on roles(:app) do
			unless `git rev-parse HEAD` == `git rev-parse origin/#{fetch(:branch)}`
				puts "WARNING: HEAD is not the same as origin/development"
				puts "Run `git push` to sync changes."
				exit
			end
		end
	end
	
	desc 'Initial Deploy'
	task :initial do
		on roles(:app) do
			before 'deploy:restart', 'puma:start'
			invoke 'deploy'
		end
	end
	
	# before :starting,     :check_revision
	after  :finishing,    :compile_assets
	after  :finishing,    :cleanup
end
