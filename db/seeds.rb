user1 = User.where(email: "test1@example.com").first_or_create(password: "password", password_confirmation: "password")
user2 = User.where(email: "test2@example.com").first_or_create(password: "password", password_confirmation: "password")

user1_herbs = [
  {
    name: "Blue Lotus Root",
    scientific_name: "Nymphaea caerulea",
    summary: "Also known as the Sacred Blue Lily, it's benefits have laid claims for thousands of years as a sleep aid, aphrodisiac and much more while it boasts having psychoactive properties.",
    benefit: "Improves Sleep, Eases Anxiety and Aphrodisiac",
    warning: "Psychoactive properties should not be mixes with other substances",
    image: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c7/Lotus_india_cropped.jpg/1200px-Lotus_india_cropped.jpg"
  }
]

user2_herbs = [
  {
    name: "Damiana",
    scientific_name: "Turnera diffusa",
    summary: "A small shrub with beautiful yellow flowers, its prides itself in having aphrodisiatic properties while being a mood evelator",
    benefit: "Improves Mood, Aphrodisiac & Eases Stomach Problem",
    warning: "High doses are not safe for Neurological Reasons",
    image: "https://www.herbalhealinginc.com/wp-content/uploads/HERBS-083.jpg"
  }
]

user1_herbs.each do |herb|
  user1.herbs.create(herb)
  p "created: #{herb}"
end

user2_herbs.each do |herb|
  user2.herbs.create(herb)
  p "created: #{herb}"
end