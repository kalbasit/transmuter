require "bundler/gem_tasks"

# Require RSpec tasks
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

# Monkey patch Bundler::GemHelper
#
# Git flow create the tag after finishing a release however this breaks
# <b>rake release</b> because it expects that no tag for the current version
# is present, this patch overrides this behaviour to skip version tagging if
# the tag already exists instead of raising an exception
Bundler::GemHelper.class_eval <<-END, __FILE__, __LINE__ + 1
  # Tag the current version
  def tag_version
    unless already_tagged?
      sh %(git tag -a -m "Version \#{version}" \#{version_tag})
      Bundler.ui.confirm "Tagged \#{version_tag}"
    end
    yield if block_given?
  rescue
    Bundler.ui.error "Untagged \#{version_tag} due to error"
    sh_with_code "git tag -d \#{version_tag}"
    raise
  end

  # The original method raises an exception, we should override it
  def guard_already_tagged
  end

  # This method check if the tag has already been tagged
  def already_tagged?
    if sh('git tag').split(/\n/).include?(version_tag)
      true
    else
      false
    end
  end
END

# The default task is tests
task :default => :spec
