set :application, "laddernator"
set :domain, "veez@li44-246.members.linode.com"
set :deploy_to, "/var/www/apps/#{application}"
set :mongrel_command, "true"
set :passenger_restart, "touch /var/www/apps/#{application}/current/tmp/restart.txt"

Rake.clear_tasks('vlad:update','vlad:start_web')

namespace :vlad do
  task :deploy => ['vlad:update', 'vlad:migrate', 'vlad:start']

  remote_task :update, :roles => :app do
    symlink = false
    begin
      run "git --git-dir=#{scm_path}/repo.git init --shared"
      ssh_url = "ssh://#{target_host}#{scm_path}/repo.git"
      system("git","push","-f",ssh_url,"#{revision.sub(/^head$/i,'HEAD')}:refs/tags/release-#{release_name}")
      run [ "mkdir -p #{release_path}",
            "git --git-dir=#{scm_path}/repo.git archive release-#{release_name}|tar xf - -C #{release_path}",
            "chmod -R g+w #{latest_release}",
            "rm -rf #{latest_release}/log #{latest_release}/public/system #{latest_release}/tmp/pids",
            "mkdir -p #{latest_release}/db #{latest_release}/tmp",
            "ln -s #{shared_path}/log #{latest_release}/log",
            "ln -s #{shared_path}/system #{latest_release}/public/system",
            "ln -s #{shared_path}/pids #{latest_release}/tmp/pids",
            "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
          ].join(" && ")

      symlink = true
      run "rm -f #{current_path} && ln -s #{latest_release} #{current_path}"

      run "echo #{now} $USER #{revision} #{File.basename release_path} >> #{deploy_to}/revisions.log"
    rescue => e
      run "rm -f #{current_path} && ln -s #{previous_release} #{current_path}" if
        symlink
      run "rm -rf #{release_path}"
      raise e
    end
  end

  remote_task :start_web, :roles => :app do
    run "#{passenger_restart}"
  end
end
