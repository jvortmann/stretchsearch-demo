class ProductSearch
  include StretchSearch

  search :name, :contains
end
