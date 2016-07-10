task :copy_sqlite, roles: :app do
  run "cp #{current_path}/db/test.sqlite3 #{release_path}/db/"
end