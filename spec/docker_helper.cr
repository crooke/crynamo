require "docker"

module DockerHelper
  class DynamoDbContainer
    @container : Docker::Container

    def initialize
      client = Docker::Client.new
      host_config = {
        "PortBindings": {
          "8000/tcp": [{"HostPort": "8000"}],
        },
      }
      @container = client.containers.create("amazon/dynamodb-local", host_config: host_config)
    end

    def start
      @container.start
    end

    def stop
      @container.stop
      @container.remove
    end
  end
end
