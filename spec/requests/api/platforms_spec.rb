# typed: false
require 'rails_helper'

RSpec.describe "Platforms API", type: :request do
  describe "Query for data on platforms" do
    let(:user) { create(:confirmed_user) }
    let(:platform) { create(:platform) }
    let(:platform2) { create(:platform) }

    it "returns basic data for platform" do
      sign_in(user)
      platform
      query_string = <<-GRAPHQL
        query($id: ID!) {
          platform(id: $id) {
            id
            name
          }
        }
      GRAPHQL

      result = VideoGameListSchema.execute(
        query_string,
        context: { current_user: user },
        variables: { id: platform.id }
      )
      expect(result.to_h["data"]["platform"]).to eq(
        {
          "id" => platform.id.to_s,
          "name" => platform.name
        }
      )
    end

    it "returns data for a platform when searching" do
      sign_in(user)
      platform
      query_string = <<-GRAPHQL
        query($query: String!) {
          platformSearch(query: $query) {
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
        variables: { query: platform.name }
      )
      expect(result.to_h["data"]["platformSearch"]["nodes"]).to eq(
        [{
          "id" => platform.id.to_s,
          "name" => platform.name
        }]
      )
    end

    it "returns data for platforms when listing" do
      sign_in(user)
      platform
      platform2
      query_string = <<-GRAPHQL
        query {
          platforms {
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
      expect(result.to_h["data"]["platforms"]["nodes"]).to eq(
        [
          {
            "id" => platform.id.to_s,
            "name" => platform.name
          },
          {
            "id" => platform2.id.to_s,
            "name" => platform2.name
          }
        ]
      )
    end
  end
end
