
namespace :pebbles do
  desc "Synching migration hackety hack"
  task :sync do
    system "rsync -ruv vendor/plugins/pebbles/db/migrate db"
    system "rsync -ruv vendor/plugins/pebbles/public ."
  end
end
