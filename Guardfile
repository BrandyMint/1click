# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exists?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

guard :bundler do
  require 'guard/bundler'
  require 'guard/bundler/verify'
  helper = Guard::Bundler::Verify.new

  files = ['Gemfile']
  files += Dir['*.gemspec'] if files.any? { |f| helper.uses_gemspec?(f) }

  # Assume files are symlinked from somewhere
  files.each { |file| watch(helper.real_path(file)) }
end

guard 'ctags-bundler', :src_path => ["app", "lib"] do
  watch(/^(app|lib|test\/support)\/.*\.rb$/)
  watch('Gemfile.lock')
end
group :red_green_refactor, halt_on_fail: true do
  # guard 'rspec', :parallel => true, :parallel_cli => '-n 2' do
  #guard :rspec,
    #cmd: 'spring rspec',
    #spec_paths: ['spec'],
    #run_all: { cmd: 'NO_FOCUS=true spring rspec' },
    #all_on_start: false,
    #failed_mode: :focus,
    #debugger: true do
    #watch(%r{^spec/.+_spec\.rb$})
    #watch(%r{^lib/(.+)\.rb$}) { |m| "spec/lib/#{m[1]}_spec.rb" }
    #watch(%r{^spec/spec_helper.rb}) { 'spec' }

    ### Rails example
    #watch(%r{^app/(.+)\.rb$})                           { |m| "spec/#{m[1]}_spec.rb" }
    #watch(%r{^app/(.*)(\.erb|\.haml)$})                 { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
    #watch(%r{^app/controllers/(.+)_(controller)\.rb$})  { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
    #watch(%r{^spec/support/(.+)\.rb$})                  { 'spec' }
    #watch(%r{^config/routes.rb})                           { 'spec/routing' }
    #watch(%r{^app/controllers/application_controller.rb})  { 'spec/controllers' }

    #### Capybara features specs
    #watch(%r{^app/views/(.+)/.*\.(erb|haml)$}) { |m| "spec/features/#{m[1]}_spec.rb" }

    ### Turnip features and steps
    #watch(%r{^spec/acceptance/(.+)\.feature$})
    #watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$}) { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
  #end

guard :minitest, all_on_start: false do
  # with Minitest::Spec
  #watch(%r{^spec/(.*)_spec\.rb$})
  #watch(%r{^lib/(.+)\.rb$})         { |m| "spec/#{m[1]}_spec.rb" }
  #watch(%r{^spec/spec_helper\.rb$}) { 'spec' }

  # Rails 4
  watch(%r{^app/(.+)\.rb$})                               { |m| "test/#{m[1]}_test.rb" }
  watch(%r{^app/controllers/application_controller\.rb$}) { 'test/controllers' }
  watch(%r{^app/controllers/(.+)_controller\.rb$})        { |m| "test/integration/#{m[1]}_test.rb" }
  watch(%r{^app/views/(.+)_mailer/.+})                   { |m| "test/mailers/#{m[1]}_mailer_test.rb" }

  watch(%r{^lib/(.+)\.rb$})                               { |m| "test/lib/#{m[1]}_test.rb" }
  watch(%r{^test/.+_test\.rb$})
  watch(%r{^test/test_helper\.rb$}) { 'test' }
end
    end
