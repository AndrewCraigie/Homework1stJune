require_relative("../db/sql_runner")
require_relative("film")

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def buy_ticket(film)
    if @funds <= film.price # = true
      @funds -= film.price
    end
    return Ticket.new('customer_id' => @id, 'film_id' => film.id)

  end

  def tickets_bought
    sql = "SELECT * FROM tickets WHERE customer_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|result| Ticket.new(result)}
  end 

  def films()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    films = SqlRunner.run(sql, values, film_id)
    return Film.new(results[0])
  end

  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    data = SqlRunner.run(sql)
    return data.map{|customer| Customer.new(customer)}
  end

    def self.delete_all()
      sql = "DELETE FROM customers"
      SqlRunner.run(sql)
    end

  end
