# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

unless User.any?
  puts 'Criando usuários admin'
  default_password = 'foobar123'

  users = [
    { name: 'Lucas Santos da Costa', email: 'lucas.costa@clicksign.com', password: default_password },
    { name: 'Vinicius Lima', email: 'vinicius.lima@clicksign.com', password: default_password },
    { name: 'Deyvid Nascimento', email: 'deyvid.nascimento@clicksign.com', password: default_password },
    { name: 'Dérick Pimenta', email: 'derick.pimenta@clicksign.com', password: default_password }
  ]

  users.each do |user|
    if User.create(user)
      puts "Criado usuário #{user[:name]} - #{user[:email]}"
    end
  end
end
