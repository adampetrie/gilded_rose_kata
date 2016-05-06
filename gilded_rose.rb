def update_quality(items)
  items.each do |item|
    if item.name == 'NORMAL ITEM'
      update_normal_item_quality(item)
      next
    end

    if item.name == 'Aged Brie'
      update_aged_brie_quality(item)
      next
    end

    if item.name == 'Sulfuras'
      update_sulfuras_quality(item)
      next
    end

    if item.name == 'Backstage passes to a TAFKAL80ETC concert'
      update_backstage_pass_quality(item)
      next
    end
  end
end

def update_normal_item_quality(item)
  if item.sell_in <= 0
    item.quality -= 2 if item.quality != 0
  else
    item.quality -= 1 if item.quality != 0
  end

  item.sell_in -= 1
end

def update_aged_brie_quality(item)
  if item.sell_in > 0 && item.quality < 50
    item.quality += 1
  elsif item.sell_in <= 0
    if item.quality == 49
      item.quality +=1
    elsif item.quality < 50
      item.quality +=2
    end
  end

  item.sell_in -= 1
end

def update_sulfuras_quality(item)
end

def update_backstage_pass_quality(item)
  if item.sell_in > 10
    item.quality += 1 if item.quality < 50
  elsif item.sell_in >= 6 && item.sell_in <= 10
    if item.quality == 49
      item.quality +=1
    elsif item.quality < 50
      item.quality +=2
    end
  elsif item.sell_in <= 5 && item.sell_in > 0
    if item.quality == 49
      item.quality +=1
    elsif item.quality < 50
      item.quality +=3
    end
  elsif item.sell_in <= 0
    item.quality = 0
  end

  item.sell_in -= 1
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

