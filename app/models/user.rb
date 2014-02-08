class User < ActiveRecord::Base
  attr_accessible :location
  has_secure_password

  # By default, use the GEOS implementation for spatial columns.
  self.rgeo_factory_generator = RGeo::Geos.factory_generator

  # But use a geographic implementation for the :lonlat column.
  set_rgeo_factory_for_column(:location, RGeo::Geographic.spherical_factory(:srid => 4326))
end
