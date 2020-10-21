# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
cats = [
    {
      name: 'Raisins',
      age: 3,
      enjoys: 'eating the houseplants'
    },
    {
      name: 'Toast',
      age: 2,
      enjoys: 'giving thumbs up'
    },
    {
      name: 'Bob',
      age: 7,
      enjoys: 'laying around'
    }
  ]

  cats.each do |attributes|
    Cat.create attributes
    puts "creating cat#{ attributes }"
  end
