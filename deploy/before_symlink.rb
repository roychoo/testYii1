app_current = ::File.expand_path("#{release_path}/../../current")
vendor_dir  = "#{app_current}/vendor"

deploy_user  = "www-data"
deploy_group = "www-data"

release_vendor = "#{release_path}/vendor"

::FileUtils.cp_r vendor_dir, release_vendor if ::File.exists?(vendor_dir)
::FileUtils.chown_R deploy_user, deploy_group, release_vendor if ::File.exists?(release_vendor)

composer_command = "php"
composer_command << " #{release_path}/composer.phar"
composer_command << " --no-dev"
composer_command << " --prefer-source"
composer_command << " --optimize-autoloader"
composer_command << " install"

run "cd #{release_path} && #{composer_command}"
