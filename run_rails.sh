#!/bin/sh
while ! pg_isready ; do sleep 10 ; echo " awating db" ; done 
source ~/.profile
echo "*** Rails setup ***" 

if [ ! -x /app/quotes/bin/rails ] 
then
	gem install --user-install rails -v 7.0.3.1
	rails new . --api -d postgresql -T -s --skip-git 

	/app/quotes/bin/bundle add spring --group "development, test" --skip-install 
	/app/quotes/bin/bundle add pry --group "development, test" --skip-install 
	/app/quotes/bin/bundle add factory_bot_rails --group "development, test" --skip-install 
	/app/quotes/bin/bundle add faker --group "development, test" --skip-install 
	/app/quotes/bin/bundle add rspec --group "development, test" --skip-install
	/app/quotes/bin/bundle add rspec-rails --group "development, test" --skip-install
	/app/quotes/bin/bundle add prettyprint --group "development, test" --skip-install
	/app/quotes/bin/bundle add rubocop --group "development" --skip-install
	/app/quotes/bin/bundle add rubocop-factory_bot --group "development" --skip-install
	/app/quotes/bin/bundle add rubocop-rails --group "development" --skip-install
	/app/quotes/bin/bundle add rubocop-rspec --group "development" --skip-install
	/app/quotes/bin/bundle add solargraph --group "development" --skip-install
	/app/quotes/bin/bundle add database_cleaner-active_record --group "test" --skip-install
	/app/quotes/bin/bundle add shoulda-matchers --group "test" --skip-install --version "~> 5"
	/app/quotes/bin/bundle add simplecov --group "test" --skip-install 
	/app/quotes/bin/bundle add jwt --skip-install 
	/app/quotes/bin/bundle add bcrypt --skip-install 
	/app/quotes/bin/bundle add rack-cors --skip-install 
	/app/quotes/bin/bundle add active_model_serializers --skip-install 
	/app/quotes/bin/bundle install 
	/app/quotes/bin/bundle exec spring binstub --all

	/app/quotes/bin/rails db:prepare
	/app/quotes/bin/rails db:test:prepare
	/app/quotes/bin/rails g rspec:install
fi

/app/quotes/bin/bundle install
/app/quotes/bin/bundle exec spring binstub --all

rm -fr /app/quotes/tmp/pids/server.pid
/app/quotes/bin/rails s -b 0.0.0.0
