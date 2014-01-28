require 'override_task'

namespace :db do

  alias_task_chain :charset => :environment do
    config = ActiveRecord::Base.configurations[RAILS_ENV || 'development']
    case config['adapter']
    when 'sqlserver'
      ActiveRecord::Base.establish_connection(config)
      puts ActiveRecord::Base.connection.charset
    else
      Rake::Task["db:charset:original"].execute
    end
  end

  namespace :structure do

    alias_task_chain :dump => :environment do
      if ActiveRecord::Base.configurations[RAILS_ENV]["adapter"] != "sqlserver"
        Rake::Task["db:structure:dump:original"].execute
      end
    end

  end

  namespace :test do

    alias_task_chain :clone_structure => [ "db:structure:dump", "db:test:purge" ] do
      if ActiveRecord::Base.configurations[RAILS_ENV]["adapter"] != "sqlserver"
        Rake::Task["db:test:clone_structure:original"].execute
      end
    end

    alias_task_chain :purge => :environment do
      abcs = ActiveRecord::Base.configurations
      case abcs["test"]["adapter"]
      when "sqlserver"
        ActiveRecord::Base.establish_connection(:test)
        begin
          ActiveRecord::Base.connection.recreate_database
        rescue
          ActiveRecord::Base.connection.recreate_database!(abcs["test"]["database"])
        end
      else
        Rake::Task["db:test:purge:original"].execute
      end
    end

  end

end
