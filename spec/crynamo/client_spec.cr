require "../spec_helper"
require "../docker_helper"

CONFIG = Crynamo::Configuration.new(
  "foo",
  "secret",
  "us-east-1",
  "http://localhost:8000"
)

dynamodb = DockerHelper::DynamoDbContainer.new

Spec.before_suite {
  dynamodb.start
}

Spec.after_suite {
  dynamodb.stop
}

describe Crynamo::Client do
  client = Crynamo::Client.new(CONFIG)

  it "it supports getting values" do
    data = client.get!("pets", {name: "Scooby"})

    data.should eq({
      "lifespan" => 100.0,
      "name"     => "Scooby",
    })
  end

  it "it handles non-existent values" do
    data = client.get!("pets", {name: "Missing"})

    data.should eq({} of String => JSON::Any::Type)
  end

  it "it supports inserting values" do
    put_data = client.put!("pets", {
      name:            "Thor",
      age:             7,
      family_friendly: false,
    })
    get_data = client.get!("pets", {name: "Thor"})

    put_data.should eq(nil)

    get_data.should eq({
      "name"            => "Thor",
      "age"             => 7,
      "family_friendly" => false,
    })
  end

  it "it supports deleting values" do
    client.delete!("pets", {name: "Fin"}).should eq(nil)
  end
end
