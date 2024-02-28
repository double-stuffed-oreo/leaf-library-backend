require 'rails_helper'

RSpec.describe "Herbs", type: :request do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
    )
  }

  describe "GET /index" do
    it 'gets a list of herbs' do 
      herb = user.herbs.create(
        name: "Blue Lotus Root",
        scientific_name: "Nymphaea caerulea",
        summary: "Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.",
        benefit: "Improves Sleep, Eases Anxiety and Aphrodisiac",
        warning: "Psychoactive properties should not be mixes with other substances",
        image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg"
      )

      get '/herbs'

      herb = JSON.parse(response.body)
      expect(herb.first['name']).to eq("Blue Lotus Root")
      expect(herb.first['scientific_name']).to eq("Nymphaea caerulea")
      expect(herb.first['summary']).to eq("Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.")
      expect(herb.first['benefit']).to eq("Improves Sleep, Eases Anxiety and Aphrodisiac")
      expect(herb.first['warning']).to eq("Psychoactive properties should not be mixes with other substances")
      expect(herb.first['image']).to eq("https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg")
      expect(response).to have_http_status(200)
    end
  end

  it 'creates a new herb' do 
    herb_params = {
      herb: {
        name: "Blue Lotus Root",
        scientific_name: "Nymphaea caerulea",
        summary: "Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.",
        benefit: "Improves Sleep, Eases Anxiety and Aphrodisiac",
        warning: "Psychoactive properties should not be mixes with other substances",
        image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg",
        user_id: user.id
      }
    }
    post '/herbs', params: herb_params

    expect(response).to have_http_status(200)
    json = JSON.parse(response.body)
    herb = Herb.first 
    expect(herb['name']).to eq("Blue Lotus Root")
    expect(herb['scientific_name']).to eq("Nymphaea caerulea")
    expect(herb['summary']).to eq("Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.")
    expect(herb['benefit']).to eq("Improves Sleep, Eases Anxiety and Aphrodisiac")
    expect(herb['warning']).to eq("Psychoactive properties should not be mixes with other substances")
    expect(herb['image']).to eq("https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg")
    expect(herb['user_id']).to eq(user.id)
  end

  it "doesn't create an herb without a name" do
    herb_params = {
      herb: {
        scientific_name: "Nymphaea caerulea",
        summary: "Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.",
        benefit: "Improves Sleep, Eases Anxiety and Aphrodisiac",
        warning: "Psychoactive properties should not be mixes with other substances",
        image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg",
        user_id: user.id
      }
    }
    post '/herbs', params: herb_params

    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['name']).to include "can't be blank"
  end

  it "doesn't create an herb without a summary" do
    herb_params = {
      herb: {
        name: "Blue Lotus Root",
        scientific_name: "Nymphaea caerulea",
        benefit: "Improves Sleep, Eases Anxiety and Aphrodisiac",
        warning: "Psychoactive properties should not be mixes with other substances",
        image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg",
        user_id: user.id
      }
    }
    post '/herbs', params: herb_params

    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['summary']).to include "can't be blank"
  end 

  it "doesn't create an herb without a benefit" do
    herb_params = {
      herb: {
        name: "Blue Lotus Root",
        scientific_name: "Nymphaea caerulea",
        summary: "Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.",
        warning: "Psychoactive properties should not be mixes with other substances",
        image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg",
        user_id: user.id
      }
    }
    post '/herbs', params: herb_params

    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['benefit']).to include "can't be blank"
  end 

  it "doesn't create an herb without a warning" do
    herb_params = {
      herb: {
        name: "Blue Lotus Root",
        scientific_name: "Nymphaea caerulea",
        summary: "Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.",
        benefit: "Improves Sleep, Eases Anxiety and Aphrodisiac",
        image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg",
        user_id: user.id
      }
    }
    post '/herbs', params: herb_params

    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['warning']).to include "can't be blank"
  end 

  it "doesn't create an herb without a image" do
    herb_params = {
      herb: {
        name: "Blue Lotus Root",
        scientific_name: "Nymphaea caerulea",
        summary: "Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.",
        benefit: "Improves Sleep, Eases Anxiety and Aphrodisiac",
        warning: "Psychoactive properties should not be mixes with other substances",
        user_id: user.id
      }
    }
    post '/herbs', params: herb_params

    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['image']).to include "can't be blank"
  end 

  it "doesn't create an herb without a user id" do
    herb_params = {
      herb: {
        name: "Blue Lotus Root",
        scientific_name: "Nymphaea caerulea",
        summary: "Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.",
        benefit: "Improves Sleep, Eases Anxiety and Aphrodisiac",
        warning: "Psychoactive properties should not be mixes with other substances",
        image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg"
      }
    }
    post '/herbs', params: herb_params

    expect(response.status).to eq 422
    json = JSON.parse(response.body)
    expect(json['user_id']).to include "can't be blank"
  end  
end