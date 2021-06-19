class Cache
    def initialize
        @memory = {}
    end

    def get(request)
        @memory[request]
    end
    