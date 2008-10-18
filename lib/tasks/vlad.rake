begin
  require 'vlad'
  Vlad.load :scm => :git
rescue LoadError
end
