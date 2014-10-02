require 'pg'

# TODO: rename this file to superheroes.rb

# TODO: change the name of the class
class SuperheroesConnection

  def initialize
    # TODO: change the dbname to 'superheroes'
    @conn = PG.connect(:dbname =>'superheroes', :host => 'localhost')
    # TODO: change the insert to insert a superhero
    @conn.prepare("insert_superhero", "INSERT INTO superheroes (name, alter_ego, has_cape, power, arch_nemesis) VALUES ($1, $2, $3, $4, $5)")
  end

  def delete_all
    # TODO: fix this
    @conn.exec( "delete from superheroes" )
  end

  def insert_superhero(name, alter_ego, has_cape, power, arch_nemesis)
    # TODO: fix this
    @conn.exec_prepared("insert_superhero", [name, alter_ego, has_cape, power, arch_nemesis])
  end

  # TODO: change method name
  def print_superhero
    # TODO: fix this
    @conn.exec( "select * from superheroes order by name desc" ) do |result|
      result.each do |row|
        # TODO: fix this to pretty print the superheroes
        cape = if row['has_cape'] == "t" 
                puts 'wearing a cape'
              else
                puts 'not wearing a cape'
              end
        puts "#{row['alter_ego']} who is really #{row['name']} has #{row['power']}as tools to beat #{row['arch_nemesis']} while #{cape}"
      end
    end
  end   

  def close
    @conn.close
  end
end

begin
  # TODO: fix this
  connection = SuperheroesConnection.new

  # connection.delete_all

  # TODO: insert superheroes here.
  connection.insert_superhero('SpiderMan', 'Peter Parker', false, 'spidey skills','Green Goblin');
 connection.insert_superhero('Superman', 'Clark Kent', true, 'flyin,laser vision,super strength','DoomsDay');
  connection.insert_superhero('Batman', 'Bruce Wayne', true, 'saving Gotham','Joker');

  # TODO: fix this to use better method name
  connection.print_superhero
rescue Exception => e
    puts e.message
    puts e.backtrace.inspect
ensure
  connection.close
end
