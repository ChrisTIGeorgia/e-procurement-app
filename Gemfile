if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end

source 'https://rubygems.org'

gem 'bundler', '~>1.2.0'
gem "rails", "3.1.3"
gem "mysql2", "~> 0.3.11" # this gem works better with utf-8

gem "json"
gem 'jquery-rails', '>= 2.1'
gem 'jquery-ui-rails'
gem "devise", "2.0.4" # user authentication
gem "cancan", ">= 1.6.8" # user authorization
gem "formtastic", ">= 2.1.1" # create forms easier
gem "formtastic-bootstrap", :git => "https://github.com/cgunther/formtastic-bootstrap.git", :branch => "bootstrap-2"
gem "nested_form", ">= 0.1.1", :git => "https://github.com/davidray/nested_form.git" # easily build nested model forms with ajax links
gem "globalize3", "0.2.0" # internationalization
gem "psych", ">=1.3.4" # yaml parser - default psych in rails has issues
gem "will_paginate", ">= 3.0.3" # add paging to long lists
gem "gon", ">= 2.2.2" # push data into js
gem "dynamic_form", ">= 1.1.4" # to see form error messages
gem "i18n-js", ">= 2.1.2" # to show translations in javascript
gem "paperclip", ">= 3.0.4" # to upload files
gem "has_permalink", ">= 0.1.4" # create permalink slugs for nice urls
gem "capistrano", ">= 2.12.0" # to deploy to server
gem 'rvm-capistrano'
gem "exception_notification", ">= 2.5.2" # send an email when exception occurs
gem "useragent", :git => "https://github.com/jilion/useragent.git" # browser detection
gem "passenger" # App server gem

#gem "pdfkit", ">= 0.5.2" # generate pdfs
#gem "use_tinymce", ">= 0.0.15" # wysiwyg
#gem "rails_autolink", ">= 1.0.9" # convert string to link if it is url
#gem 'acts_as_commentable', '>= 2.0.1' #comments
#gem "paper_trail", ">= 2.6.3" # keep audit log of all transactions



# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "sass-rails", "3.1.4"
  gem "coffee-rails", "~> 3.1.1"
  gem "uglifier", ">= 1.0.3"
  gem "twitter-bootstrap-rails", "~> 2.1.0"
  gem "bootstrap-datepicker-rails"
  gem "jquery-datatables-rails", github: 'rweng/jquery-datatables-rails'
end
