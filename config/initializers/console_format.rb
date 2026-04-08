# This initializer is added to improve the readability of floating-point numbers
# in the Rails console (e.g. for financial reporting debugging).
if defined?(Rails::Console)
  class Float
    def inspect
      "%.2f" % self
    end
  end
end
