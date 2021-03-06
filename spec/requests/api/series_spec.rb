# typed: false
require 'rails_helper'

RSpec.describe "Series API", type: :request do
  describe "Query for data on series" do
    let(:user) { create(:confirmed_user) }
    let(:series) { create(:series) }
    let(:series2) { create(:series) }

    it "returns basic data for series" do
      sign_in(user)
      series
      query_string = <<-GRAPHQL
        query($id: ID!) {
          series(id: $id) {
            id
            name
          }
        }
      GRAPHQL

      result = VideoGameListSchema.execute(
        query_string,
        context: { current_user: user },
        variables: { id: series.id }
      )
      expect(result.to_h["data"]["series"]).to eq(
        {
          "id" => series.id.to_s,
          "name" => series.name
        }
      )
    end

    it "returns data for a series when searching" do
      sign_in(user)
      series
      query_string = <<-GRAPHQL
        query($query: String!) {
          seriesSearch(query: $query) {
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
        variables: { query: series.name }
      )
      expect(result.to_h["data"]["seriesSearch"]["nodes"]).to eq(
        [{
          "id" => series.id.to_s,
          "name" => series.name
        }]
      )
    end

    it "returns data for series' when listing" do
      sign_in(user)
      series
      series2
      query_string = <<-GRAPHQL
        query {
          seriesList {
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
      expect(result.to_h["data"]["seriesList"]["nodes"]).to eq(
        [
          {
            "id" => series.id.to_s,
            "name" => series.name
          },
          {
            "id" => series2.id.to_s,
            "name" => series2.name
          }
        ]
      )
    end
  end
end
