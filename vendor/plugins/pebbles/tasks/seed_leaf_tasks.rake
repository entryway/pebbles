
namespace :seed_leaf do
  desc "Synching migration hackety hack"
  task :sync do
    system "rsync -ruv vendor/plugins/seed-leaf/db/migrate db"
    system "rsync -ruv vendor/plugins/seed-leaf/public ."
  end
end