#<< gg/geom/geom
#<< gg/geom/svg/boxplot
#<< gg/geom/reparam/boxplot

class gg.geom.Boxplot extends gg.geom.Geom
  @aliases: ["schema", "boxplot"]

  parseSpec: ->
    super

    @reparam = new gg.geom.reparam.Boxplot @g, {name: "schema-reparam"}
    @render = new gg.geom.svg.Boxplot @layer, {}

  posMapping: ->
    ys = ['q1', 'median', 'q3', 'lower', 'upper',
      'min', 'max', 'lower', 'upper', 'outlier']
    xs = ['x']
    map = {}
    _.each ys, (y) -> map[y] = 'y'
    _.each xs, (x) -> map[x] = 'x'
    map



