#configuration on serverDedied
require "bundler/capistrano"
load 'deploy/assets'

default_run_options[:pty] = true

set :application, "skybox"
set :repository,  "git@skycrafting.com:skybox.git"

set :scm, :git
set :branch, "master"
set :user, "sphynxx"
set :scm_username, "mdelaunay"
set :use_sudo, false

set :deploy_via, :copy
set :deploy_to, "/var/www/skybox"
set :keep_releases, 3

role :web, "ks3264779.kimsufi.com"
role :app, "ks3264779.kimsufi.com"
role :db,  "ks3264779.kimsufi.com", :primary => true


namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
    
  end
end

#configuration on VPS
# require "bundler/capistrano"
# load 'deploy/assets'

# default_run_options[:pty] = true

# set :application, "Skypics"
# set :repository,  "git@github.com:mdelaunay/Skypics.git"

# set :scm, :git
# set :branch, "master"
# set :user, "sphynxx"
# set :scm_username, "mdelaunay"
# set :use_sudo, false

# set :deploy_via, :copy
# set :deploy_to, "/var/www/Skypics"
# set :keep_releases, 3

# role :web, "vps10410.ovh.net"
# role :app, "vps10410.ovh.net"
# role :db,  "vps10410.ovh.net", :primary => true


# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

