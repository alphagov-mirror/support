# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path("config/application", __dir__)

Support::Application.load_tasks

Rake::Task["default"].clear if Rake::Task.task_defined?(:default)

task default: %i[lint spec]
