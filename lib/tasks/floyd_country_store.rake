namespace :floyd_country_store do
  desc "Recreates floyd_countrye_store database runs migrations and imports old data"
  task :import do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    system 'ruby script/runner lib/import/xcart_import.rb'
  end
end
