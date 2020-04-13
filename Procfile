web: puma -C config/puma.rb
sidekiq: bundle exec sidekiq -q default -e $RAILS_ENV -c 5
release: bundle exec rake db:migrate
