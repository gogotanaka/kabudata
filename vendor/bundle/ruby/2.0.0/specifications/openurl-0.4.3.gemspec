# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "openurl"
  s.version = "0.4.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jonathan Rochkind", "Ross Singer"]
  s.date = "2013-04-17"
  s.email = ["rochkind@jhu.edu", "rossfsinger@gmail.com"]
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md"]
  s.homepage = "https://github.com/openurl/openurl"
  s.require_paths = ["lib"]
  s.rubygems_version = "2.0.2"
  s.summary = "a Ruby library to create, parse and use NISO Z39.88 OpenURLs"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<marc>, [">= 0"])
      s.add_runtime_dependency(%q<ensure_valid_encoding>, [">= 0"])
    else
      s.add_dependency(%q<marc>, [">= 0"])
      s.add_dependency(%q<ensure_valid_encoding>, [">= 0"])
    end
  else
    s.add_dependency(%q<marc>, [">= 0"])
    s.add_dependency(%q<ensure_valid_encoding>, [">= 0"])
  end
end
