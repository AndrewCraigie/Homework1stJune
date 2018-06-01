require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pry-byebug')

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()


customer1 = Customer.new({
  'name' => 'Frank',
  'funds' => '30'
  })
customer1.save()

customer2 = Customer.new({
  'name' => 'John',
  'funds' => '20'
  })
customer2.save()

customer3 = Customer.new({
  'name' => 'Paul',
  'funds' => '10'
  })
customer3.save()


film1 = Film.new({
  'title' => 'Goodfellas',
  'price' => '15'
  })
film1.save()

film2 = Film.new({
  'title' => 'Scarface',
  'price' => '10'
  })
  film2.save()

  film3 = Film.new({
    'title' => 'Casino',
    'price' => '20'
    })
  film3.save()

  tickets1 = Ticket.new({'customer_id' => customer1.id, 'film_id' => film1.id})
  tickets1.save()
  tickets2 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film2.id})
  tickets2.save()
  tickets3 = Ticket.new({'customer_id' => customer2.id, 'film_id' => film3.id})
  tickets3.save()
  ticket4 = customer1.buy_ticket(film1)

  binding.pry
  nil
