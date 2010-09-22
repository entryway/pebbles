namespace :pebbles do
  desc "Syncs public & db/migrate to your app. Use touch cmd on pebbles files if sync problems occur"
  task :sync do
    db_migrate_dir  = Dir[File.dirname(__FILE__) + '/../../db/migrate'][0]
    public_dir      = Dir[File.dirname(__FILE__) + '/../../public'][0]
    system "rsync -ruv #{db_migrate_dir} #{Rails.root}/db"
    system "rsync -ruv #{public_dir} #{Rails.root}"
  end
end
