class Person
 attr_accessor :first_name,:last_name,:city ,:ids
#  Struct.new(:first_name, :last_name, :city ,:ids) #used attr_accessor instead  can be used this too 

def initialize
     self.ids = [] # on object creation initialize this to an array
end
  # a method to print out a csv record for the current Person.
  # note that you can easily re-arrange columns here, if desired.
  # also note that this method compensates for blank fields.
  def print_csv_record
    print last_name.empty? ? "," : "\"#{last_name}\","
    print first_name.empty? ? "," : "\"#{first_name}\","
    print city.empty? ? "" : "\"#{city}\","
    p "\n"
  end
end

p = Person.new
p.last_name = ""
p.first_name = "Plucket"
p.city = "San Diego"

#now add things to the array in the object
p.ids.push("1")
p.ids.push("55")

#iterate
p.ids.each do |i|
  puts i
end