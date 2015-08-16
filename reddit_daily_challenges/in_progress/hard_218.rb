#!/usr/bin/ruby

# Challenge: Hard #218: https://www.reddit.com/r/dailyprogrammer/comments/39ixxi/20150612_challenge_218_hard_elevator_scheduling/

# Elevator Scheduling


# Each car has a list of passengers inside of it, as well as a list of floors its queued up to stop at
class Car
  attr_reader :id, :capacity, :speed, :position, :passengers, :floor_queue
  
  def initialize(id, capacity, speed, start_floor)
    @id = id
    @capacity = capacity
    @speed = speed
    @position = start_floor
    @passengers = Hash.new
    @floor_queue = Array.new
  end
  
  # once passenger gets on lift, their personal request is deleted and transferred to the lift
  def add_passenger(person)
    @capacity -= 1
    @passengers.push(person)
  end
  
  def remove_passenger(person)
    @capacity += 1
    @passengers.delete(person)
  end
  
  add_floor_to_queue(floor_num)
    @floor_queue[floor_num] = floor_num
  end
  
  remove_floor_from_queue(floor_num)
    @floor_queue[floor_num] = 0
  end
end

# Each request is just a time of request, and source/destination floors
class Request
  attr_reader :time, :source_floor, :dest_floor
  
  def initialize(time, source_floor, dest_floor)
    @time = time
    @source_floor = source_floor
    @dest_floor = dest_floor
  end
end

# Each person can have a queue of requests (due to quirk of the challenge)
# Queues must be added and removed in order - i.e. cannot complete a later request, before the earlier request is finished
class Person
  attr_reader :id
  attr_accessor :request_queue
  
  def initialize(id, request)
    @id = id
    @request_queue = [request]
  end
  
  # push request to end of queue
  def add_request(request)
    @request_queue.push(request)
  end
  
  def get_request()
    return @request_queue.fetch(0)
  end
  
  # remove request from start of queue
  def remove_request()
    return @request_queue.shift
  end
end

# Each floor basically has a queue of people wanting to go up and down
# People can only be added to and removed from the queue in order, so every passenger must wait their turn
class Floor
  attr_reader :floor_num, :down_queue, :up_queue
  
  def initialize(floor_num)
    @floor_num = floor_num
    down_queue = Array.new
    up_queue = Array.new
  end
  
  # add request to end of queue
  def add_down_request(person)
    down_queue.push(person)
  end
  
  def add_up_request(person)
    up_queue.push(person)
  end
  
  # remove x requests from front of queue
  #  - i.e. when 3 people get on the same lift, pull 3 people from queue
  def remove_down_request(num_requests)
    down_queue.shift(num_requests)
  end
  
  def remove_up_request(num_requests)
    up_queue.shift(num_requests)
  end
end

car1 = Car.new("C1", 12, 0.1, 1)
person1 = Person.new("R1", Request.new(1, 1, 10))
person2 = Person.new("R2", Request.new(1, 1, 10))
floor1 = Floor.new(1)
floor1.add_up_request(person1)
floor1.add_up_request(person2)

100.times do
  car1.move()