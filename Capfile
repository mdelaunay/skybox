load 'deploy'
# Uncomment if you are using Rails' asset pipeline
    # load 'deploy/assets'
Dir['vendor/gems/*/recipes/*.rb','vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }
load 'config/deploy' # remove this line to skip loading any of the default tasks

#Securing the database.yml file
namespace :db do
  task :db_config, :except => { :no_release => true }, :role => :app do
    run "cp -f ~/skybox/config/database.yml #{release_path}/config/database.yml"

    run "mkdir #{release_path}/public/uploads && ln -s ~/skybox/uploads/sheets/ #{release_path}/public/uploads/sheets"
  end
end

after "deploy:finalize_update", "db:db_config"