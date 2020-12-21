require_relative "room"

class Hotel
    def initialize(name, rooms)
        @name = name
        @rooms = {}
        rooms.each {|k, v| @rooms[k] = Room.new(v)}
    end

    def name
        words = @name.split(" ")
        (0...words.length).each {|i| words[i] = words[i].capitalize}
        words.join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(name)
        if @rooms.has_key?(name)
            true
        else
            false
        end
    end

    def check_in(person, room)
        if room_exists?(room)
            if @rooms[room].add_occupant(person)
                puts "check in successful"
            else
                puts "sorry, room is full"
            end
        else
            puts "sorry, room does not exist"
        end
    end

    def has_vacancy?
        @rooms.each_key {|k|return true if !@rooms[k].full?}
        false
    end

    def list_rooms
        @rooms.each do |k, v|
            puts k +". *" + v.available_space.to_s
        end
    end

end
