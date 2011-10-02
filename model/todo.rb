require 'sequel'
Sequel::Model.plugin(:schema)

Sequel.connect("sqlite://todo.db")

class Todos < Sequel::Model
  unless table_exists?
    set_schema do
      primary_key :id
      text :todo
      timestamp :posted_date
    end
    create_table
  end

  def date
    self.posted_date.strftime("%Y-%m-%d %H:%M:%S")
  end

  def formatted_todo
    Rack::Utils.escape_html(self.todo).gsub(/\n/, "<br>")
  end
end
