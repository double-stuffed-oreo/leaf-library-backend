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
end
