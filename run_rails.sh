#!/bin/sh
while ! pg_isready ; do sleep 10 ; echo " Awating for db..." ; done 

source ~/.profile

echo "*** Rails setup ***" 
export WORKDIR=/app/$APPDIR

if [ ! -x $WORKDIR/bin/rails ] 
then
	gem install --user-install rails -v 7.0.3.1
	rails new . --api -d postgresql -T -s --skip-git 
	$WORKDIR/bin/bundle add spring --group "development, test" --skip-install 
	$WORKDIR/bin/bundle add pry --group "development, test" --skip-install 
	$WORKDIR/bin/bundle add factory_bot_rails --group "development, test" --skip-install 
	$WORKDIR/bin/bundle add faker --group "development, test" --skip-install 
	$WORKDIR/bin/bundle add rspec --group "development, test" --skip-install
	$WORKDIR/bin/bundle add rspec-rails --group "development, test" --skip-install
	$WORKDIR/bin/bundle add prettyprint --group "development, test" --skip-install
	$WORKDIR/bin/bundle add rubocop --group "development" --skip-install
	$WORKDIR/bin/bundle add rubocop-factory_bot --group "development" --skip-install
	$WORKDIR/bin/bundle add rubocop-rails --group "development" --skip-install
	$WORKDIR/bin/bundle add rubocop-rspec --group "development" --skip-install
	$WORKDIR/bin/bundle add solargraph --group "development" --skip-install
	$WORKDIR/bin/bundle add database_cleaner-active_record --group "test" --skip-install
	$WORKDIR/bin/bundle add shoulda-matchers --group "test" --skip-install --version "~> 5"
	$WORKDIR/bin/bundle add simplecov --group "test" --skip-install 
	$WORKDIR/bin/bundle add jwt --skip-install 
	$WORKDIR/bin/bundle add bcrypt --skip-install 
	$WORKDIR/bin/bundle add rack-cors --skip-install 
	$WORKDIR/bin/bundle add active_model_serializers --skip-install 
	$WORKDIR/bin/bundle install 
	$WORKDIR/bin/bundle exec spring binstub --all

	$WORKDIR/bin/rails g rspec:install
fi

# do not work without it
$WORKDIR/bin/bundle add spring --group "development, test" --skip-install 
$WORKDIR/bin/bundle install
$WORKDIR/bin/bundle exec spring binstub --all

$WORKDIR/bin/rails db:prepare
$WORKDIR/bin/rails db:development:prepare
$WORKDIR/bin/rails db:test:prepare

rm -fr $WORKDIR/tmp/pids/server.pid
$WORKDIR/bin/rails s -b 0.0.0.0
