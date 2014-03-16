class Dummy 
    attr_reader :a, :b

    def initialize(a, b)
        @a = a
        @b = b
    end

    def eql? other
        other.kind_of?(self.class) && @a == other.a
    end
    
    def hash
        @a.hash
    end

end

a = [Dummy.new(1, 2), Dummy.new(3, 4)]
b = [Dummy.new(1, 2), Dummy.new(5, 6)]
p a & b