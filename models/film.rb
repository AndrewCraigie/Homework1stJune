require_relative("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i

  end

  def films()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@id]
    films = SqlRunner.run(sql, values, customer_id)
    return Film.new(results[0])
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE film SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE * FROM films where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM films"
    data = SqlRunner.run(sql)
    return data.map{|film| Film.new(film)}
  end


    def self.delete_all()
      sql = "DELETE FROM films"
      SqlRunner.run(sql)
    end

  end
