class DefaultUpdater
  def self.update(_item)
  end
end

class NormalUpdater
  def self.update(item)
    item.sell_in -= 1
    return if item.quality == 0
    item.quality -= 1
    item.quality -= 1 if item.sell_in <= 0
  end
end

class BrieUpdater
  def self.update(item)
    item.sell_in -= 1
    item.quality += 1 if item.quality < 50
    return if item.quality == 50
    item.quality += 1 if item.sell_in <= 0
  end
end

class BackstageUpdater
  def self.update(item)
    item.sell_in -= 1
    return if item.quality >= 50
    return item.quality = 0 if item.sell_in < 0
    item.quality += 1
    item.quality += 1 if item.sell_in < 10
    item.quality += 1 if item.sell_in < 5
  end
end

class ConjureUpdater
  def self.update(item)
    item.sell_in -= 1
    item.quality -= 2
    return item.quality = 0 if item.quality < 0
    item.quality -= 2 if item.sell_in <= 0
  end
end

UPDATERS = {
  'NORMAL ITEM'                               => NormalUpdater,
  'Aged Brie'                                 => BrieUpdater,
  'Backstage passes to a TAFKAL80ETC concert' => BackstageUpdater,
  'Conjured Mana Cake'                        => ConjureUpdater
}.freeze

def update_quality(items)
  items.each do |item|
    (UPDATERS[item.name] || DefaultUpdater).update(item)
    next
  end
end

# DO NOT CHANGE THINGS BELOW -----------------------------------------

Item = Struct.new(:name, :sell_in, :quality)

# We use the setup in the spec rather than the following for testing.
#
# Items = [
#   Item.new("+5 Dexterity Vest", 10, 20),
#   Item.new("Aged Brie", 2, 0),
#   Item.new("Elixir of the Mongoose", 5, 7),
#   Item.new("Sulfuras, Hand of Ragnaros", 0, 80),
#   Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20),
#   Item.new("Conjured Mana Cake", 3, 6),
# ]
