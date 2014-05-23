# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ae_users_migrator}
  s.version = "1.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nat Budin"]
  s.date = %q{2011-05-23}
  s.default_executable = %q{export_ae_users}
  s.description = %q{Importer and exporter for ae_users databases using JSON-based dumpfiles}
  s.email = %q{natbudin@gmail.com}
  s.executables = ["export_ae_users"]
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "ae_users_migrator.gemspec",
    "bin/export_ae_users",
    "lib/ae_users_migrator.rb",
    "lib/ae_users_migrator/export.rb",
    "lib/ae_users_migrator/import.rb"
  ]
  s.homepage = %q{http://github.com/nbudin/ae_users_migrator}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.0}
  s.summary = %q{Migrate ae_users installations using dumpfiles}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 2.3"])
    else
      s.add_dependency(%q<activerecord>, [">= 2.3"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 2.3"])
  end
end

