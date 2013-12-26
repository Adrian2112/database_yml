require 'pathname'
require 'fileutils'
require 'etc'

class DatabaseYML
  SCRIPT_RAILS = File.join('script', 'rails')
  DRIVERS = %W(mysql postgresql sqlite3)
  TEMPLATES_DIR = File.join(File.expand_path(File.dirname(__FILE__)), "templates")

  def initialize(database)
    @database = database || 'sqlite3'
  end

  def create!

    return unless DRIVERS.include? @database

    if self.class.in_rails_application?
      generate_database_yml!
      return
    else
      puts "Must be executed in a rails directory"
    end

  end

  def self.in_rails_application?
    file_exist = File.exist?('Gemfile')
    return false unless file_exist

    open('Gemfile') { |f| !f.grep(/rails/).empty? }
  end

  def generate_database_yml!
    template = File.open(File.join(TEMPLATES_DIR, @database)).read
    output_file = File.new(File.join(Dir.pwd, "config", "database.yml"), "w")

    username = Etc.getlogin
    application_name = File.basename(Dir.getwd)

    template.gsub!("USERNAME", username)
    template.gsub!("APPLICATION_NAME", application_name)

    output_file.write(template)

    puts "database.yml created for #{@database}"
  end

end
