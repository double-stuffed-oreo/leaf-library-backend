require 'rails_helper'

RSpec.describe Herb, type: :model do
  let(:user) { User.create(
    email: 'test@example.com',
    password: 'password',
    password_confirmation: 'password'
    )
  }
  it 'should validate name' do
    herb = user.herbs.create(
      scientific_name: "Nymphaea caerulea",
      summary: "Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.",
      benefit: "Improves Sleep, Eases Anxiety and Aphrodisiac",
      warning: "Psychoactive properties should not be mixes with other substances",
      image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg"
    )
    expect(herb.errors[:name]).to include("can't be blank")
  end

  it 'should validate summary' do
    herb = user.herbs.create(
      name: "Blue Lotus Root",
      scientific_name: "Nymphaea caerulea",
      benefit: "Improves Sleep, Eases Anxiety and Aphrodisiac",
      warning: "Psychoactive properties should not be mixes with other substances",
      image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg"
    )
    expect(herb.errors[:summary]).to include("can't be blank")
  end

  it 'should validate benefit' do
    herb = user.herbs.create(
      name: "Blue Lotus Root",
      scientific_name: "Nymphaea caerulea",
      summary: "Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.",
      warning: "Psychoactive properties should not be mixes with other substances",
      image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg"
    )
    expect(herb.errors[:benefit]).to include("can't be blank")
  end

  it 'should validate warning' do
    herb = user.herbs.create(
      name: "Blue Lotus Root",
      scientific_name: "Nymphaea caerulea",
      summary: "Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.",
      benefit: "Improves Sleep, Eases Anxiety and Aphrodisiac",
      image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg"
    )
    expect(herb.errors[:warning]).to include("can't be blank")
  end

  it 'should validate image' do
    herb = user.herbs.create(
      name: "Blue Lotus Root",
      scientific_name: "Nymphaea caerulea",
      summary: "Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.",
      benefit: "Improves Sleep, Eases Anxiety and Aphrodisiac",
      warning: "Psychoactive properties should not be mixes with other substances"
    )
    expect(herb.errors[:image]).to include("can't be blank")
  end
end