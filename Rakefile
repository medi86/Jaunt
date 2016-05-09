# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks


tasks = Rake.application.instance_variable_get('@tasks')
tasks['test'].clear_actions if tasks['test']
tasks['spec'].clear_actions if tasks['spec']

mrspec = Proc.new do
    sh 'mrspec', '--fail-fast'
end

task :test, &mrspec
task :spec, &mrspec
