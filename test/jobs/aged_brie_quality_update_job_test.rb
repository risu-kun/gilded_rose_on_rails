require 'test_helper'

class AgedBrieQualityUpdateJobTest < ActiveSupport::TestCase
  def test_depreciation_before_sell_date
    item = Item.new(sell_in: 11, quality: 10, name: "Aged Brie")
    job = AgedBrieQualityUpdateJob.new

    assert_equal -1, job.depreciation(item)
  end

  def test_depreciation_on_sell_date
    item = Item.new(sell_in: 0, quality: 10, name: "Aged Brie")
    job = AgedBrieQualityUpdateJob.new

    assert_equal -2, job.depreciation(item)
  end

  def test_depreciation_after_sell_date
    item = Item.new(sell_in: -1, quality: 10, name: "Aged Brie")
    job = AgedBrieQualityUpdateJob.new

    assert_equal -2, job.depreciation(item)
  end

  def test_aging
    item = Item.new(sell_in: 5, quality: 10, name: "Aged Brie")
    job = AgedBrieQualityUpdateJob.new

    assert_equal 1, job.aging(item)
  end

  def test_min_quality
    job = AgedBrieQualityUpdateJob.new

    assert_equal 0, job.min_quality
  end

  def test_max_quality
    job = AgedBrieQualityUpdateJob.new

    assert_equal 50, job.max_quality
  end
end