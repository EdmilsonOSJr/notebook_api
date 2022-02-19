namespace :dev do
  desc "TODO"
  task setup: :environment do

    puts "Cadastrando os tipos de Contatos..."
    
    kinds = %w(Amigo Comercial Conhecido)

    kinds.each do |kind|
      Kind.create!(
        description: kind
      )
    end
    puts "Tipos cadastrados."



    puts "Cadastrando contatos."
    100.times do |i|
      Contact.create!(
          name: Faker::Name::name,
          email: Faker::Internet.email,
          birthdate:Faker::Date.between(from: 35.years.ago, to: 18.years.ago), 
          kind: Kind.all.sample
      )
    end
    puts "Contatos cadastrados com sucesso."

  end
end
