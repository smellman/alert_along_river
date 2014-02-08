class Area < ActiveRecord::Base
  attr_accessible :name, :area, :left, :right, :parent_left, :parent_right

  # By default, use the GEOS implementation for spatial columns.
  self.rgeo_factory_generator = RGeo::Geos.factory_generator

  # But use a geographic implementation for the :lonlat column.
  set_rgeo_factory_for_column(:area, RGeo::Geographic.spherical_factory(:srid => 4326))
end
