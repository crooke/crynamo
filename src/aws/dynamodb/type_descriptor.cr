module AWS::DynamoDB
  # Represents a DynamoDB type descriptor
  # (see http://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_AttributeValue.html)
  class TypeDescriptor
    def self.string
      "S"
    end

    def self.number
      "N"
    end

    def self.binary
      "B"
    end

    def self.bool
      "BOOL"
    end

    def self.null
      "NULL"
    end

    def self.map
      "M"
    end

    def self.list
      "L"
    end

    def self.string_set
      "SS"
    end

    def self.number_set
      "NS"
    end

    def self.binary_set
      "BS"
    end
  end
end
