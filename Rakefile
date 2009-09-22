require 'rubygems'
require 'rake'

namespace :pebbles do
  desc "Synching migration hackety hack"
  task :sync do
    system "rsync -ruv #{File.dirname(__FILE__)}/db/migrate ../../../db"
    system "rsync -ruv #{File.dirname(__FILE__)}/public ../../../"
  end
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "pebbles"
    gem.summary = %Q{ecommerce}
    gem.description = %Q{entryway's ecommerce solution}
    gem.email = "bobbywilson0@gmail.com"
    gem.homepage = "http://github.com/entryway/pebbles"
    gem.authors = ["gustin", "jonsgreen", "bobbyw"]
    gem.add_dependency "collectiveidea-awesome_nested_set"
    gem.add_dependency "bcurren-ssl_requirement"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "pebbles #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
