# Obtained from rails source code
# https://github.com/rails/rails/blob/3-2-stable/railties/lib/rails/script_rails_loader.rb

require 'pathname'
require 'fileutils'

class DatabaseYML
  SCRIPT_RAILS = File.join('script', 'rails')
  DRIVERS = %W(mysql postgresql sqlite3)
  TEMPLATES_DIR = File.join(File.expand_path(File.dirname(__FILE__)), "templates")
  

  def initialize(database)
    @database = database || 'sqlite3'
  end

  def create!

    return unless DRIVERS.include? @database

    cwd = Dir.pwd
    return unless self.class.in_rails_application? || self.class.in_rails_application_subdirectory?

    if self.class.in_rails_application?
      generate_database_yml!
      return
    end

    Dir.chdir("..") do
      # Recurse in a chdir block: if the search fails we want to be sure
      # the application is generated in the original working directory.
      create! unless cwd == Dir.pwd
    end
  rescue SystemCallError
    # could not chdir, no problem just return
  end

  def self.in_rails_application?
    File.exists?(SCRIPT_RAILS)
  end

  def self.in_rails_application_subdirectory?(path = Pathname.new(Dir.pwd))
    File.exists?(File.join(path, SCRIPT_RAILS)) || !path.root? && in_rails_application_subdirectory?(path.parent)
  end

  def generate_database_yml!
    FileUtils.cp(File.join(TEMPLATES_DIR, @database), File.join(Dir.pwd, "config", "database.yml"))
    puts "database.yml created for #{@database}"
  end

end
