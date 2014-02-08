root = exports ? this

root.test = () -> alert "test"

root.init_map = () ->
  unless root.map_obj
    root.map_obj = new OpenLayers.Map('map')
    layer = new OpenLayers.Layer.OSM("OSM")
    root.map_obj.addLayer(layer)
    root.map_obj.setCenter(new OpenLayers.LonLat(79.879392385483, 7.5985157489784).transform(
      new OpenLayers.Projection("EPSG:4326"),
      root.map_obj.getProjectionObject()
    ), 12)
    return
root.init_vector = () ->
  if root.map_obj
    root.vector = new OpenLayers.Layer.Vector("Vector Layer")
    root.map_obj.addLayer(root.vector)
    return
root.editable_vector = (insert_element) ->
  if root.map_obj and root.vector
    root.map_obj.addControl(new OpenLayers.Control.MousePosition())
    root.map_obj.addControl(new OpenLayers.Control.EditingToolbar(root.vector))

    out_options =
      'internalProjection': root.map_obj.baseLayer.projection,
      'externalProjection': new OpenLayers.Projection("EPSG:4326")
    root.write_wkt = new OpenLayers.Format.WKT(out_options)
    options =
      hover: true,
      onSelect: (feature) ->
        str = root.write_wkt.write(feature, false)
        insert_element.val(str)
        return
    select = new OpenLayers.Control.SelectFeature(vector, options)
    root.map_obj.addControl(select)
    select.activate()
    return
root.init_editable_map = (element) ->
  elem = $(element)
  root.init_map()
  root.init_vector()
  root.editable_vector(elem)
  return
root.insert_vector = (element) ->
  root.insert_vector_with_style(element, null)
  return
root.insert_vector_blue_color = (element) ->
  style =
    strokeColor: "#0000ff",
    fillColor: "#0000ff",
    fillOpacity: 0.4,
    strokeWidth: 1
  root.insert_vector_with_style(element, style)
  return
root.insert_vector_with_style = (element, style) ->
  val = $(element).val()
  if val == ""
    return
  unless root.map_obj
    root.init_map()
  unless root.vector
    root.init_vector()
  unless root.read_wkt
    in_options =
      'internalProjection': root.map_obj.baseLayer.projection,
      'externalProjection': new OpenLayers.Projection("EPSG:4326")
    root.read_wkt = new OpenLayers.Format.WKT(in_options)
  features = root.read_wkt.read(val)
  if features
    if features.constractor != Array
      features = [features]
    append_features = []
    for feature in features
      unless root.bounds
        root.bounds = feature.geometry.getBounds()
      else
        root.bounds.extend(feature.geometry.getBounds())
      if style
        feature.style = style
        append_features.push(feature)
      else
        append_features.push(feature)
    root.vector.addFeatures(append_features)
    root.map_obj.zoomToExtent(root.bounds)
  return
	