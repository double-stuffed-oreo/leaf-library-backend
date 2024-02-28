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

  describe "PATCH /update" do
    it "updates a herb" do
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
  
      updated_herb_params = {
        herb: {
          name: "Sea Moss",
          scientific_name: "Chondrus crispus",
          summary: "Sea moss is about 80% water and contains small amounts of protein and carbohydrates. It's also a source of carrageenan, a natural food thickening agent.",
          benefit: "Improving the immune system, slowing down digestion, balancing blood sugar levels, supporting a healthy heart",
          warning: "Some people have reported feeling tired and sleepy after taking sea moss. Raw sea moss can also have an earthy, ocean-like taste, not unlike an oyster or a clam.",
          image: "https://wildling.com/cdn/shop/articles/Irish_Sea_Moss.webp?v=1694632157&width=750"
        }
      }
      herb = Herb.first
      
      patch "/herbs/#{herb.id}", params: updated_herb_params

      expect(response).to have_http_status(200)
  
      updated_herb = Herb.first
      
      expect(updated_herb.name).to eq('Sea Moss')
      expect(updated_herb.scientific_name).to eq('Chondrus crispus')
      expect(updated_herb.summary).to eq("Sea moss is about 80% water and contains small amounts of protein and carbohydrates. It's also a source of carrageenan, a natural food thickening agent.")
      expect(updated_herb.benefit).to eq("Improving the immune system, slowing down digestion, balancing blood sugar levels, supporting a healthy heart")
      expect(updated_herb.warning).to eq("Some people have reported feeling tired and sleepy after taking sea moss. Raw sea moss can also have an earthy, ocean-like taste, not unlike an oyster or a clam.")
      expect(updated_herb.image).to eq("https://wildling.com/cdn/shop/articles/Irish_Sea_Moss.webp?v=1694632157&width=750")
    end

    it 'returns a 422 status code' do
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

      invalid_herb_params = {
        herb: {
          name: nil,
          scientific_name: nil,
          summary: nil,
          benefit: nil,
          warning: nil,
          image: nil
        }
      }

      herb = Herb.first
      patch "/herbs/#{herb.id}", params: invalid_herb_params

      expect(response).to have_http_status(422)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a herb' do
      herb = Herb.create(
        name: "Blue Lotus Root",
          scientific_name: "Nymphaea caerulea",
          summary: "Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.",
          benefit: "Improves Sleep, Eases Anxiety and Aphrodisiac",
          warning: "Psychoactive properties should not be mixes with other substances",
          image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg",
          user_id: user.id
      )

      delete "/herbs/#{herb.id}"

      expect(response).to have_http_status(200)
      expect(Herb.find_by(id: herb.id)).to be_nil
    end
  end
end