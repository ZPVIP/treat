module Treat
  # Abstract and concrete structures extending the
  # Tree::Node class to represent textual entities:
  #
  # - Collection
  # - Document
  # - Zone (a Section, Title, Paragraph, or List)
  # - Sentence
  # - Constituent (a Phrase or Clause)
  # - Token (a Word, Number, Punctuation, or Symbol).
  module Entities
    # Require Entity first.
    require 'treat/entities/entity'
    # Then require all possible entities.
    require 'treat/entities/collection'
    require 'treat/entities/document'
    require 'treat/entities/zones'
    require 'treat/entities/sentence'
    require 'treat/entities/constituents'
    require 'treat/entities/tokens'
    # Make the constants buildable.
    constants.each do |entity|
      define_singleton_method(entity) do |value='', id=nil|
        const_get(entity).build(value, id)
      end
    end
    # Cache a list of defined entity types to
    # improve performance.
    @@list = []
    # Provide a list of defined entity types,
    # as non-camel case identifiers.
    def self.list
      return @@list unless @@list.empty?
      self.constants.each do |constant|
        @@list << :"#{ucc(constant)}"
      end
      @@list
    end
    # Return the hierarchy level of the entity
    # class, the minimum being a Token and the
    # maximum being a Collection.
    def self.rank(type)
      klass = Entities.const_get(cc(type))
      compare = lambda { |a,b| a == b || a < b }
      return 0 if compare.call(klass, Token)
      return 1 if compare.call(klass, Constituent)
      return 2 if compare.call(klass, Sentence)
      return 3 if compare.call(klass, Zone)
      return 4 if compare.call(klass, Document)
      return 5 if compare.call(klass, Collection)
    end
  end
end
