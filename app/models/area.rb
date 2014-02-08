class Area < ActiveRecord::Base
  attr_accessible :name, :area, :left, :right, :parent_left, :parent_right

  # By default, use the GEOS implementation for spatial columns.
  self.rgeo_factory_generator = RGeo::Geos.factory_generator

  # But use a geographic implementation for the :lonlat column.
  set_rgeo_factory_for_column(:area, RGeo::Geographic.spherical_factory(:srid => 4326))

  def users
    return User.joins("INNER JOIN areas ON areas.id = #{id} AND ST_Contains(areas.area::geometry, users.location::geometry)").all if area
    return Array.new
  end

  def target_users
    ret = Array.new
    ret = ret + left_obj.target_users unless left_obj.nil?
    ret = ret + right_obj.target_users unless right_obj.nil?
    ret = ret + self.users
    return ret
  end

  def parent_ids
    ret = Array.new
    ret = ret + parent_left_obj.parent_ids unless parent_left_obj.nil?
    ret = ret + parent_right_obj.parent_ids unless parent_right_obj.nil?
    ret = ret + [self.id]
    return ret
  end

  def child_ids
    ret = Array.new
    ret = ret + left_obj.child_ids unless left_obj.nil?
    ret = ret + right_obj.child_ids unless right_obj.nil?
    ret = ret + [self.id]
    return ret
  end

  def can_append_child_ids
    self.parent_ids | self.child_ids
  end
  
  def can_append_child
    self.class.where(self.class.arel_table[:id].not_in self.can_append_child_ids)
  end

  def left_obj
    return nil unless self.left
    self.class.find_by_id(self.left)
  end

  def right_obj
    return nil unless self.right
    self.class.find_by_id(self.right)
  end

  def parent_left_obj
    return nil unless self.parent_left
    self.class.find_by_id(self.parent_left)
  end

  def parent_right_obj
    return nil unless self.parent_right
    self.class.find_by_id(self.parent_right)
  end

  def append_child(child_area)
    begin
      if self.left_obj.nil?
        self.left = child_area.id
        child_area.set_parent(self)
        return true
      elsif self.right_obj.nil?
        self.right = child_area.id
        child_area.set_parent(self)
        return true
      else
        return false
      end
    rescue
      return false
    end
  end

  def set_parent(parent_node)
    if self.parent_left_obj.nil?
      self.parent_left = parent_node.id
    elsif self.parent_right_obj.nil?
      self.parent_right = parent_node.id
    else
      raise "can't set parent"
    end
  end
end
