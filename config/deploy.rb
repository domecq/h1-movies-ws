set :application, "h1movies"
set :repository,  "gitosis@devsrv.h1lab.com:h1movies.git"

set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "h1lab.com"                          # Your HTTP server, Apache/etc
role :app, "h1lab.com"                          # This may be the same as your `Web` server
role :db,  "h1lab.com", :primary => true # This is where Rails migrations will run


# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

 If you are using Passenger mod_rails uncomment this:
 namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "touch #{File.join(current_path,'tmp','restart.txt')}"
   end
 end