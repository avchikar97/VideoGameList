# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strong
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/kaminari-activerecord/all/kaminari-activerecord.rbi
#
# kaminari-activerecord-1.1.1
module Kaminari
end
module Kaminari::Activerecord
end
module Kaminari::ActiveRecordRelationMethods
  def entry_name(options = nil); end
  def reset; end
  def total_count(column_name = nil, _options = nil); end
  def without_count; end
end
module Kaminari::PaginatableWithoutCount
  def last_page?; end
  def load; end
  def out_of_range?; end
  def total_count; end
end
module Kaminari::ActiveRecordModelExtension
  extend ActiveSupport::Concern
end
module Kaminari::ActiveRecordExtension
  extend ActiveSupport::Concern
end
module Kaminari::ActiveRecordExtension::ClassMethods
  def inherited(kls); end
end
