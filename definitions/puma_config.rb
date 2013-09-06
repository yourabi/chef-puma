define :puma_config, owner: nil, group: nil, directory: nil, puma_directory: nil, rackup: nil,
                     environment: "production", daemonize: false, pidfile: nil, config_path: nil, state_path: nil,
                     stdout_redirect: nil, stderr_redirect: nil, output_append: false, user: nil,
                     quiet: false, thread_min: 0, thread_max: 16, bind: nil, control_app_bind: nil,
                     workers: 0, activate_control_app: true, monit: true, logrotate: true, exec_prefix: nil do


  # Set defaults if not supplied by caller.
  # Working directory of rails app (where config.ru is)
  unless params[:directory]
    params[:directory] = "/srv/apps/#{params[:name]}"
  end
  unless params[:app_directory]
    params[:app_directory] = params[:directory]
  end
  unless params[:user]
    params[:user] = "vagrant"
  end
  params[:working_dir] = "#{params[:directory]}"

  unless params[:puma_directory]
    params[:puma_directory] = "#{params[:directory]}/shared/puma"
  end

  unless params[:config_path]
    params[:config_path] = "#{params[:puma_directory]}/#{params[:name]}.config"
  end

  unless params[:state_path]
    params[:state_path] = "#{params[:puma_directory]}/#{params[:name]}.state"
  end

  unless params[:bind]
    params[:bind] = "unix://#{params[:puma_directory]}/#{params[:name]}.sock"
  end

  unless params[:control_app_bind]
    params[:control_app_bind] = "unix://#{params[:puma_directory]}/#{params[:name]}_control.sock"
  end

  unless params[:pidfile]
    params[:pidfile] = "#{params[:puma_directory]}/#{params[:name]}.pid"
  end

  unless params[:stdout_redirect]
    params[:stdout_redirect] = "#{params[:puma_directory]}/stdout.log"
  end

  unless params[:stderr_redirect]
    params[:stderr_redirect] = "#{params[:puma_directory]}/stderr.log"
  end

  unless params[:exec_prefix]
    params[:exec_prefix] = "bundle exec"
  end

  # Create app working directory with owner/group if specified
  directory params[:puma_directory] do
    recursive true
    owner params[:owner] if params[:owner]
    group params[:group] if params[:group]
  end

  template params[:name] do
    source "puma.rb.erb"
    path "#{params[:config_path]}"
    cookbook "puma"
    mode "0644"
    owner params[:owner] if params[:owner]
    group params[:group] if params[:group]
    variables params
  end

  template "puma_kill.sh" do
    source "puma_kill.sh.erb"
    path "#{params[:puma_directory]}/puma_kill.sh"
    cookbook "puma"
    mode "0755"
    owner params[:owner] if params[:owner]
    group params[:group] if params[:group]
    variables params
  end

  template "puma_phased_restart.sh" do
    source "puma_phased_restart.sh.erb"
    path "#{params[:puma_directory]}/puma_phased_restart.sh"
    cookbook "puma"
    mode "0755"
    owner params[:owner] if params[:owner]
    group params[:group] if params[:group]
    variables params
  end

  template "puma_restart.sh" do
    source "puma_restart.sh.erb"
    path "#{params[:puma_directory]}/puma_restart.sh"
    cookbook "puma"
    mode "0755"
    owner params[:owner] if params[:owner]
    group params[:group] if params[:group]
    variables params
  end

  puma_params = params
  if params[:monit]
    include_recipe "monit"
    monitrc puma_params[:name], :action => :enable do
      template_source 'monitrc.erb'
      template_cookbook 'puma'
      variables puma_params
    end
  end

  if params[:logrotate]
    logrotate_app puma_params[:name] do
      cookbook "logrotate"
      path [ puma_params[:stdout_redirect], puma_params[:stderr_redirect] ]
      frequency "daily"
      rotate 30
      size "5M"
      options ["missingok", "compress", "delaycompress", "notifempty", "dateformat -%Y%m%d%s", "dateext"]
      variables puma_params
    end
  end
end
