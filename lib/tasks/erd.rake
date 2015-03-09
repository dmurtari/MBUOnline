require 'rake'

desc 'Generate Entity Relationship Diagram'
task :generate_erd do
  Rake::Task["db:migrate"].invoke
  system "erd --inheritance --direct --attributes=foreign_keys,content"
end
