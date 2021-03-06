# typed: false
require 'rails_helper'

RSpec.describe "Engines API", type: :request do
  describe "Query for data on engines" do
    let(:user) { create(:confirmed_user) }
    let(:engine) { create(:engine) }
    let(:engine2) { create(:engine) }

    it "returns basic data for engine" do
      sign_in(user)
      engine
      query_string = <<-GRAPHQL
        query($id: ID!) {
          engine(id: $id) {
            id
            name
          }
        }
      GRAPHQL

      result = VideoGameListSchema.execute(
        query_string,
        context: { current_user: user },
        variables: { id: engine.id }
      )
      expect(result.to_h["data"]["engine"]).to eq(
        {
          "id" => engine.id.to_s,
          "name" => engine.name
        }
      )
    end

    it "returns data for a engine when searching" do
      sign_in(user)
      engine
      query_string = <<-GRAPHQL
        query($query: String!) {
          engineSearch(query: $query) {
            nodes {
              id
              name
            }
          }
        }
      GRAPHQL

      result = VideoGameListSchema.execute(
        query_string,
        context: { current_user: user },
        variables: { query: engine.name }
      )
      expect(result.to_h["data"]["engineSearch"]["nodes"]).to eq(
        [{
          "id" => engine.id.to_s,
          "name" => engine.name
        }]
      )
    end

    it "returns data for engines when listing" do
      sign_in(user)
      engine
      engine2
      query_string = <<-GRAPHQL
        query {
          engines {
            nodes {
              id
              name
            }
          }
        }
      GRAPHQL

      result = VideoGameListSchema.execute(
        query_string,
        context: { current_user: user }
      )
      expect(result.to_h["data"]["engines"]["nodes"]).to eq(
        [
          {
            "id" => engine.id.to_s,
            "name" => engine.name
          },
          {
            "id" => engine2.id.to_s,
            "name" => engine2.name
          }
        ]
      )
    end
  end
end
