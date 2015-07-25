$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'campbell'

class String
  def undent
    indentation = slice(/^\s+/).length
    gsub(/^.{#{ indentation }}/, '')
  end
end
