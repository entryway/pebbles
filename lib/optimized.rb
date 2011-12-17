# Nimble Method - Guerrilla's Guide to Optimizing Rails Applications

# Rails surrounds every SQL call and ActionView::Base#render with Benchmark#realtime.
# Benchmark#realtime allocates unnecessary 45k per call.
#
# Impact:
# When copying 120 tasks in Acunote this costs 120M. Patch improves performance
# from 6s to 5s.
#
# Notes:
# Helps when you do read, create, update lots of AR records, or execute any other
# SQL, or call #render(:partial) in a loop.
module Benchmark
    def realtime
        r0 = Time.now
        yield
        r1 = Time.now
        r1.to_f - r0.to_f
    end
    module_function :realtime
end


# Comparison of BigDecimal's (used by Rails for Numeric data types) to booleans
# is slow because it requires unnecessary method_missing call and exception catch.
#
# Impact:
# When rendering 120 tasks in Acunote this costs 4M. Patch improves performance
# by 100-120ms.
#
# Notes:
# Helps when you have the imprudence to accidentally compare BigDecimal's with
# true or false.
class BigDecimal
    alias_method :eq_without_boolean_comparison, :==
    def eq_with_boolean_comparison(other)
        return false if [FalseClass, TrueClass].include? other.class
        eq_without_boolean_comparison(other)
    end
    alias_method :==, :eq_with_boolean_comparison
end