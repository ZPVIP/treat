module Treat
  # Formatters handle conversion of Entities to and from
  # external file formats.
  module Formatters
    # Readers read a document and create the top-level entity
    # corresponding to the content of the document.
    module Readers
      extend Group
      self.type = :transformer
      self.targets = [:collection, :document]
      self.default = :autoselect
    end
    # Serializers transform entities into a storable format.
    module Serializers
      extend Group
      self.type = :computer
      self.targets = [:entity]
      self.default = :yaml
    end
    # Unserializers recreate entities from a serialized format.
    module Unserializers
      extend Group
      self.type = :transformer
      self.targets = [:collection, :document]
      self.default = :autoselect
    end
    # Visualizers transform entities into a visualizable format.
    module Visualizers
      extend Group
      self.type = :computer
      self.targets = [:entity]
      self.default = :tree
    end
    # Cleaners strip a text from its mark up.
    module Cleaners
      extend Group
      self.type = :transformer
      self.targets = [:document]
      self.default = :html
    end
    extend Treat::Category
  end
end

