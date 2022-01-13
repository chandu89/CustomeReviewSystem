# frozen_string_literal: true

# Modularise in single file
module Models
end

Dir.glob("#{File.dirname(__FILE__)}/models/*.rb").sort.each(&method(:require))
